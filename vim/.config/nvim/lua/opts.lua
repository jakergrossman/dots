-- DEFAULT OPTIONS {{{

-- leader key
vim.g.mapleader = " "

-- 4 wide soft tab
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- line number + ruler in statusline
vim.o.laststatus = 2
vim.o.ruler = true

-- 'natural' split directions
vim.o.splitright = true
vim.o.splitbelow = true

-- incremental, non-highlighted search
vim.o.hlsearch = false
vim.o.incsearch = true

-- bash-like completion
vim.o.wildmode = 'full:longest:list'

-- gotto go fast
vim.o.updatetime = 100

-- super-number
vim.o.number = true
vim.o.relativenumber = true

-- persistent undo
vim.o.undofile = true
vim.o.undodir = vim.fn.expand("~/.cache/vim/undo")

vim.o.wrap = false

vim.o.textwidth = 120
vim.o.colorcolumn = tostring(vim.o.textwidth)

-- directory specific vimrc
vim.o.exrc = true
vim.o.secure = true

vim.o.cursorline = true

-- }}}
