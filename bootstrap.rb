#!/usr/bin/env ruby

require 'json'
require 'pathname'
require 'rbconfig'

# determine os
case RbConfig::CONFIG['host_os']
when /darwin/i
  HOST_OS = 'darwin'
when /linux/i
  HOST_OS = 'linux'
else
  STDERR.puts('Platform "' + RbConfig::CONFIG['host_os'] + '" not supported')
  exit
end

# if '-n' or '--dry-run' passed to program, only print the
# actions that would be taken
$DRY_RUN = ARGV.include?('-n') || ARGV.include?('--dry-run')

HOME       = Pathname.new(ENV['HOME'])
BACKUPS    = File.join(HOME, '.backups')
REPO_ROOT  = Pathname.new(File.expand_path(File.dirname(__FILE__)))
ASPECT_DIR = File.join(REPO_ROOT, 'aspects')

json_file = File.read('aspects.json')
json = JSON.parse(json_file)

# get enabled aspects for the current system
ASPECTS = json['platforms'][HOST_OS]['aspects']

# load aspect functions
load(File.join(ASPECT_DIR, 'meta', 'aspect.rb'))

# contains the name of the current aspect
# during the execution of the aspect
$CURRENT_ASPECT = nil

# log of tasks executed for each aspect
$TASK_LOG = {}

# run each aspects tasks
ASPECTS.each do |aspect|
  $CURRENT_ASPECT = aspect

  # initialize task log for aspect
  $TASK_LOG[$CURRENT_ASPECT] = []

  # load and run tasks
  load(File.join(ASPECT_DIR, aspect, 'aspect.rb'), wrap=true)
end

# log completed tasks
if $DRY_RUN
  puts "***** DRY RUN *****"
end

$TASK_LOG.each do |aspect, tasks|
  if tasks.length > 0
    puts aspect
    tasks.each do |task|
      puts '  ' + task
    end
  end
end
