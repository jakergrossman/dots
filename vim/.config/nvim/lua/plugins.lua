return require('packer').startup(function(use)
  vim.cmd([[
    augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
  ]])


  use 'wbthomason/packer.nvim'

  use 'neovim/nvim-lspconfig'
 
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'
  use 'jose-elias-alvarez/null-ls.nvim'

  use 'airblade/vim-gitgutter'

  use 'tpope/vim-commentary'

  use 'tpope/vim-fugitive'

  -- when to tell polyglot to shut up
  vim.g.polyglot_disabled = {'sensible', 'markdown'}
  use 'sheerun/vim-polyglot'

  vim.g.tagurl_enable_mapping = false;
  use 'jakergrossman/tagurl.vim'

  use 'lukas-reineke/indent-blankline.nvim'

  use {
    'marko-cerovac/material.nvim',
    config = function()
      vim.g.material_style = 'darker'
      vim.api.nvim_exec('colo material', false)
    end
  }

  use 'tikhomirov/vim-glsl'

  use {
    'norcalli/snippets.nvim',
    config = function()
      -- keybindings
      vim.api.nvim_set_keymap("i", "<C-k>", "<cmd>lua return require('snippets').expand_or_advance(1)<CR>", { noremap=true })
      vim.api.nvim_set_keymap("i", "<C-j>", "<cmd>lua return require('snippets').advance_snippet(-1)<CR>", { noremap=true })

      -- snippet definitions
      time = function() return os.date("%H:%M:%S") end
      snippets = require('snip')
      require('snippets').snippets = require('snip')
    end
  }

  use {
    '/home/jgrossman/code/glslView-nvim',
    ft = 'glsl',
    config = function()
      local size = 512;
      local top = 75;
      local right = 25;
      require('glslView').setup({
          exe_path = '/mnt/c/Users/jake/Documents/code/glslViewer/MinSizeRel/glslViewer.exe',
          args = {
            '-l',
            '--fps', 0 ,
            '--nocursor' ,
            '-w', size,
            '-h', size,
            '-x', 1920 - size - right,
            '-y', top },
      })
    end
  }

end)
