import {join} from 'path';

import {
  Context,

  aspectFiles,
  backup,
  file,
  task,
} from 'meta';

task('xmonad', 'make directories', async () => {
  // create backup directory
  await file({
    path: Context.attributes.backupDir,
    type: 'directory',
    recursive: true
  });
});

task('xmonad', 'move originals to ~/.backups', async () => {
  let files = await aspectFiles();
  files.forEach(async src => {
    await backup({src});
  });
});

task('xmonad', 'create symlinks', async () => {
  let files = await aspectFiles();
  for (const src of files) {
    await file({
      path: join(Context.attributes.home, src),
      src: join(
        Context.attributes.root,
        'aspects',
        Context.currentAspect,
        'files',
        src
      ),
      type: 'link',
      force: true
    });
  }
  return Promise.resolve();
});
