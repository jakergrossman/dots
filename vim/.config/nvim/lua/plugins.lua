return require('packer').startup(function(use)

  use 'wbthomason/packer.nvim'

  use 'neovim/nvim-lspconfig'

  use 'jose-elias-alvarez/null-ls.nvim'

  use 'airblade/vim-gitgutter'

  use 'tpope/vim-commentary'

  use 'tpope/vim-fugitive'

  -- when to tell polyglot to shut up
  vim.g.polyglot_disabled = {'sensible', 'markdown'}
  use 'sheerun/vim-polyglot'

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

  vim.cmd([[
    augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
  ]])

end)
