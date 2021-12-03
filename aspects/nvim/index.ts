import {join} from 'path';

import {
  Context,

  aspectFiles,
  backup,
  command,
  file,
  task,
} from 'meta';

task('nvim', 'make directories', async () => {
  // create backup directory
  await file({
    path: Context.attributes.backupDir,
    type: 'directory',
    recursive: true
  });
});

task('nvim', 'move originals to ~/.backups', async () => {
  let files = await aspectFiles();
  files.forEach(async src => {
    await backup({src});
  });
});

task('nvim', 'create symlinks', async () => {
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

task('nvim', 'fetch neovim git', async () => {
  await command('git',
               ['clone',
                '--depth',
                '1',
                'https://github.com/neovim/neovim.git',
               ],
               {
                 cwd: 'vendor'
               }
  );
});

task('nvim', 'build neovim', async () => {
  await command('make',
               ['CMAKE_BUILD_TYPE=Release'],
               {
                 cwd: 'vendor/neovim'
               }
  );
});

task('nvim', 'install neovim', async () => {
  await command('make', ['install'], { cwd: 'vendor/neovim' });
});

task('nvim', 'install vim-plug', async() => {
  const autoload = join(
    Context.attributes.home,
    '.config',
    'nvim',
    'autoload'
  );


  // create autoload directory
  await file({
    path: autoload,
    type: 'directory',
    recursive: true
  });

  // download plug.vim
  await command(
    'curl',
    [
      '-fLo',
      join(autoload, 'plug.vim'),
      'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim',
    ]
  );
});

// TODO: build nvim from source?
task('nvim', 'install plugins', async() => {
  await command('nvim', ['-c', 'PlugInstall --sync', '-c', 'qa']);
});
