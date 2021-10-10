task('make directories', -> {
  FileUtils.mkdir_p(BACKUPS)
  FileUtils.mkdir_p(File.join(HOME, '.xmonad'))
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
}, __FILE__);
