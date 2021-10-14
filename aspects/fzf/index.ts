import {join} from 'path';

import {
  Context,

  command,
  task,
} from 'meta';

task('fzf', 'clone fzf from GitHub', async () => {
  await command(
    'git',
    [
      'clone',
      '--depth',
      '1',
      'https://github.com/junegunn/fzf.git',
      join(Context.attributes.home, '.fzf')
    ]
  );
});

task('fzf', 'install fzf', async () => {
  await command(
    join(Context.attributes.home, '.fzf', 'install'),
    ['--all']
  );
});
