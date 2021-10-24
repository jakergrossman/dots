-- AUTOCMDS {{{

-- foldmethod=marker on init.{vim,lua} 
vim.api.nvim_exec('autocmd BufRead init.vim,init.lua set foldmethod=marker', false)

-- Make inactive statusline more visible.
vim.api.nvim_exec('autocmd ColorScheme material hi! link StatusLineNC Visual', false)

-- }}}

-- DEFAULT OPTIONS {{{

-- leader key
vim.g.mapleader = " "
--vim.api.nvim_set_var('indent_blankline_filetype_exclude', ['notes'])

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

-- directory specific vimrc
vim.o.exrc = true
vim.o.secure = true

-- gotto go fast
vim.o.updatetime = 100

-- super-number
vim.o.number = true
vim.o.relativenumber = true

-- persistent undo
vim.o.undofile = true
vim.o.undodir = vim.fn.expand("~/.cache/vim/undo")

vim.o.wrap = false

vim.o.colorcolumn = "80"

-- }}}

-- PLUGIN CONFIG {{{

-- when to tell polyglot to shut up
vim.g.polyglot_disabled = {'sensible', 'markdown'}

-- all plugins
vim.fn['plug#begin']('~/.config/nvim/plugged')
vim.fn['plug#']('neovim/nvim-lspconfig')
vim.fn['plug#']('jose-elias-alvarez/nvim-lsp-ts-utils')
vim.fn['plug#']('jose-elias-alvarez/null-ls.nvim')
vim.fn['plug#']('nvim-lua/plenary.nvim')
vim.fn['plug#']('airblade/vim-gitgutter')
vim.fn['plug#']('tpope/vim-commentary')
vim.fn['plug#']('tpope/vim-fugitive')
vim.fn['plug#']('sheerun/vim-polyglot')
vim.fn['plug#']('jakergrossman/tagurl.vim')
vim.fn['plug#']('jakergrossman/notesft')
vim.fn['plug#']('lukas-reineke/indent-blankline.nvim')
vim.fn['plug#']('marko-cerovac/material.nvim')
vim.fn['plug#end']()

-- marko-cerovac/material.nvim
vim.g.material_style = 'darker'
vim.api.nvim_exec('colo material', false)

-- }}}

-- LSP CONFIG {{{
local nvim_lsp = require("lspconfig")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local map_on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
end

nvim_lsp.clangd.setup {
  on_attach = map_on_attach
}
nvim_lsp.tsserver.setup {
    on_attach = function(client, bufnr)
        local ts_utils = require("nvim-lsp-ts-utils")

        -- defaults
        ts_utils.setup {
            debug = false,
            disable_commands = false,
            enable_import_on_completion = true,
            import_on_completion_timeout = 5000,

            -- eslint
            eslint_enable_code_actions = true,
            eslint_bin = "eslint",
            eslint_args = {"-f", "unix", "--stdin", "--stdin-filename", "$FILENAME"},
            eslint_enable_disable_comments = true,

	    -- experimental settings!
            -- eslint diagnostics
            eslint_enable_diagnostics = true,
            eslint_diagnostics_debounce = 250,
-- formatting
            enable_formatting = true,
            formatter = "prettier",
            formatter_args = {"--stdin-filepath", "$FILENAME"},
            format_on_save = true,
            no_save_after_format = false,

            -- parentheses completion
            complete_parens = false,
            signature_help_in_parens = true,

	    -- update imports on file move
	    update_imports_on_move = false,
	    require_confirmation_on_move = false,
	    watch_dir = "/src",
        }

        -- required to enable ESLint code actions and formatting
        ts_utils.setup_client(client)

        -- mappings
        map_on_attach()
    end
}

-- }}}

-- MAPPING {{{
-- }}}
