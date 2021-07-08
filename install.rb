require 'optparse'
require 'json'
require 'pp'

# check for dependencies
deps_satisfied = true
deps = [
  "vipe",
]

# check output of `which #{pkg}`
# assumed empty     -> not installed
#         non-empty -> installed
deps.each do |d|
  which_output = `which #{d}`

  # check for empty output
  if which_output == ""
    deps_satisfied = false
    STDERR.puts "ERROR: Missing dependency \"#{d}\""
  end
end

# exit if missing any deps
if !deps_satisfied
  exit
end

install_json = "install.json"

# parse options
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: install.rb [-h] [-B INSTALL_JSON]"

  # help
  opts.on("-h", "--help", "Show this text.") do |h|
    puts opts
    exit
  end

  # force remake of #{install_json} from each package.json
  opts.on("-B", "--always-make INSTALL_JSON", "Always remake install json, save as INSTALL_JSON") do |b|
    options[:always_make] = true
    install_json = b
  end
end.parse!


# hash of filenames to file locations
symlink_map = {}

editor_blurb = <<-END_EDITOR_BLURB
# Please select which packages to install. Lines starting
# with '#' will be ignored, and an empty message aborts the install.
#
END_EDITOR_BLURB

# create install.json if it doesn't exist or -B set
if (options[:always_make] || !File.exist?("install.json"))

  # find package directories
  pkg_dirs = `find -maxdepth 1 -type d \\( ! -iname ".*" \\) -printf '%P\n'`

  # open "git commit" style editor to select packages
  enabled_pkg_dirs = `echo -n \"#{editor_blurb}#{pkg_dirs}\" | vipe`
                     .split("\n")             # split at newlines
                     .select{ |i| i[/^[^#]/]} # filter out lines starting with '#'

  # check that there are any enabled packages
  if enabled_pkg_dirs.length() == 0
    STDERR.puts "No packages selected, aborting..."
    exit
  end

  # build symlink_map
  enabled_pkg_dirs.each do |pkg|
    # check that package has package.json
    if (File.exist?(pkg + "/package.json"))
      pkg_json = File.read(pkg + "/package.json")
      obj = JSON.parse(pkg_json)

      # add package to symlink_map
      symlink_map[pkg] = {}

      # add files to symlink_map
      obj["file_locations"].each do |file| 
        symlink_map[pkg][file[0]] = file[1]
      end
    else
      STDERR.puts "WARNING: Package " + pkg + " missing package.json"
    end
  end

  # write to install.json
  File.open(install_json, "w") do |f|
    f.write(symlink_map.to_json)
  end
end

# load install_json
symlink_map = JSON.parse(File.read(install_json))

# set symlinks
symlink_map.each do |pkg, files|
  puts "symlinking package \"#{pkg}\":"
  # execute relative to pkg dir
  Dir.chdir(pkg) do
    # symlink "to" to "from"
    files.each do |from, to|
      # make parent folders if they don't exist
      system("#{File.dirname(File.expand_path(to))}")

      puts "\t#{from} -> #{File.expand_path(to)}"

      # setup link
      if (File.symlink?(File.expand_path(to)))
        # if destination is a symlink, unlink to properly link
        File.unlink(File.expand_path(to))
      else
        # if destination doesn't exist, no prep required
        if (File.exists?(File.expand_path(to)))
          # file exists, back up and link
          File.rename(File.expand_path(to), File.expand_path(to) + ".bak")
        end
      end
      File.symlink(File.expand_path(from), File.expand_path(to))
    end
  end
end
