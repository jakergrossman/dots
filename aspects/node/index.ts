import {join} from 'path';

import {
  Context,

  command,
  file,
  task,
} from 'meta';

const NODE_VERSION = '16.11.0';

const n = join(Context.attributes.root, 'vendor', 'n', 'bin', 'n');

task('node', 'create ~/n', async () => {
  await file({path: join(Context.attributes.home, 'n'), type: 'directory', recursive: true});
});

task('node', `install NodeJS v${NODE_VERSION}`, async () => {
  const env = {
    ...process.env,
    N_PREFIX: join(Context.attributes.home, 'n'),
  }

  await command(n, [NODE_VERSION], {env});
});
