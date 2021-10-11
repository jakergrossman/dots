task('make directories', -> {
  FileUtils.mkdir_p(BACKUPS)
  FileUtils.mkdir_p(File.join(HOME, '.config', 'nvim', 'autoload')) # room for plug.vim
})

context(-> {
  task('move originals to ~/.backups', -> {
    files().each do |file|
      backup(file)
    end
  })

  task('create symlinks', -> {
    files().each do |file|
      FileUtils.ln_sf(File.expand_path(File.join('files', file)), File.join(HOME, file))
    end
  })

  task('install plug.vim', -> {
    # run curl quietly
    command('curl',
            '-fLo',
            File.join(HOME, '.config', 'nvim', 'autoload', 'plug.vim'),
            '--create-dirs',
            'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  })
}, __FILE__);
