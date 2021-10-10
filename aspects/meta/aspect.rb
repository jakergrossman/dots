require 'fileutils'

# run callback in the directory of 'contextPath'
def context (callback, contextPath)
  # save current directory 
  pwd = FileUtils.pwd()

  # get new directory
  if File.directory?(contextPath)
    # contextPath is directory, use as is
    newDir = Pathname.new(File.expand_path(contextPath))
  elsif File.exists?(contextPath)
    # contextPath is file, get dirname
    newDir = Pathname.new(File.expand_path(File.dirname(contextPath)))
  else
    STDERR.puts('Failed to create context for "' + contextPath + '"')
    exit
  end

  FileUtils.cd(newDir)
  callback.()
  FileUtils.cd(pwd)
end

# run a task and log in the task list
def task (description, callback)
  if not $DRY_RUN
    callback.()
  end
  $TASK_LOG[$CURRENT_ASPECT].append(description)
end

# get aspects files in CWD
# filters items that return `true` when passed to `predicate`
# by default excludes directories
def files(predicate=lambda{ |x| File.directory?(x) })
  # return every file in a relative 'files'
  # directory, except '.' and '..'
  aspectFiles = []
  Dir.glob('**/*', File::FNM_DOTMATCH, base: 'files') {|file|
    aspectFiles << file unless predicate.(File.join('files', file))
  }
  return aspectFiles
end

# backup a file or directory
def backup (path)
  oldFile = File.join(HOME, path)
  backupDir = File.join(BACKUPS, File.dirname(path))

  if File.exist?(oldFile) and not File.symlink?(oldFile)
    # backup files

    # create backup directory
    FileUtils.mkdir_p(backupDir)

    # move old files
    FileUtils.mv(oldFile, backupDir, force: true)
  else
    # no file to backup, create directory
    FileUtils.mkdir_p(File.dirname(oldFile))
  end
end
