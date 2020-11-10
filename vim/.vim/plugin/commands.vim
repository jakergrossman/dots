command! -nargs=* Note call functions#edit(<f-args>)
command! -nargs=1 TagURL silent exec 'let @+="' . functions#vimhelp_url(<f-args>) . '"'
