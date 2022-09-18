# completion information for `rmtrash`

complete -c rmtrash -s i -l interactive -d "Prompt for removal"
complete -c rmtrash -s r -l recursive -d "Recursively remove subdirectories"
complete -c rmtrash -r -l trash-dir -d "Specify an alternate trash directory"
complete -c rmtrash -s n -l dry-run -d "Don't actually remove the file(s)"
complete -c rmtrash -s e -l empty -d "Empty the trash directory (DESTRUCTIVE)"
complete -c rmtrash -s v -l verbose -d "Explain what is being done"
complete -c rmtrash -l help -d "Print detailed help description"
