-- fish doesn't play too well with nvim
vim.o.shell = '/bin/bash'

require('opts')
require('autocmd')
require('plugins')
require('lsp')
