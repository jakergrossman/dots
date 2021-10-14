import {stat} from 'fs/promises';
import {existsSync} from 'fs';
import {dirname, join} from 'path';

import Context from './context.js';

import command from './command.js';
import file from './file.js';

export default async function backup({
  src,
  dest = Context.attributes.backupDir,
  rel = Context.attributes.home,

}: {
  src: string,
  dest?: string,
  rel?: string
}) {
  const source = join(rel, src);
  const target = join(dest, src);

  if (!existsSync(source)) {
    // nothing to backup
    return;
  }

  const stats = await stat(source);
  if (stats.isDirectory() || stats.isFile()) {
    // create parent directories if necessary
    file({path: dirname(target), type: 'directory', recursive: true});

    await command('mv', ['-f', source, target]);
  }
};
