-- AUTOCMDS {{{

-- foldmethod=marker on init.{vim,lua} 
vim.api.nvim_exec('autocmd BufRead init.vim,init.lua set foldmethod=marker', false)

-- Make inactive statusline more visible.
vim.api.nvim_exec('autocmd ColorScheme material hi! link StatusLineNC Visual', false)

-- }}}
