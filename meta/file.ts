import * as fs from 'fs/promises';
import {dirname} from 'path';

import assert from './assert.js';
import command from './command.js';

type FileInfo = {
  path: string,
  mode?: string | number,
  type: 'file' | 'directory' | 'link',
  src?: string,
  force?: boolean,
  recursive?: boolean
}

const DefaultFileInfo: FileInfo = {
  path: '.',
  mode: 0o700,
  type: 'file',
  force: false,
  recursive: false,
}

/**
 * Creates a file or directory with the specified {@link FileInfo}.
 *
 * @param `FileInfo` information about the file or directory to create.
 * @return the full path of the file or directory that was created
 */
export default async function file(info: FileInfo): Promise<string> {
  // assume unset properties from DefaultFileInfo
  info = {...DefaultFileInfo, ...info};

  try {
    switch (info.type) {
      case 'file':
        // open and close new file
        (await fs.open(info.path, 'w', info.mode)).close();
        break;
      case 'directory':
        // create a new directory
        await fs.mkdir(info.path, {recursive:info.recursive, mode:info.mode});
        break;
      case 'link':
        assert(info.src);

        // make necessary directories
        await file({
          path: dirname(info.path),
          type: 'directory',
          recursive: true
        });

        // built in fs.symlink can't do force
        await command(
          'ln',
          [
            '-s' + (info.force ? 'f' : ''),
            info.src,
            info.path
          ]
        );
    }
  } catch (err) {
    console.error(err);
    process.exit(1);
  }
  return Promise.resolve('');
}
