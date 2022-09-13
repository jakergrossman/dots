return require('packer').startup(function(use)
  vim.cmd([[
    augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
  ]])


  use 'wbthomason/packer.nvim'

  use {
    'neovim/nvim-lspconfig',
    lock = true,
    requires = {
      {
        'hrsh7th/nvim-cmp',
        requires = { 'hrsh7th/cmp-nvim-lsp', 'saadparwaiz1/cmp_luasnip' },
        config = function()
          require('lsp').setup_completion()
        end,
        lock = true,
      }
    }
  }
 
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
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip.loaders.from_snipmate').load()
      vim.api.nvim_set_keymap('i', '<C-k>', '<Plug>luasnip-expand-or-jump', { noremap = true})
      vim.api.nvim_set_keymap('i', '<C-j>', '<Plug>luasnip-jump-prev', { noremap = true})
    end,
  }

  use {
    'jakergrossman/glslView-nvim',
    ft = 'glsl',
    config = function()
      local size = 512;
      local top = 75;
      local right = 25;

      local exe_path = 'glslViewer'
      if (vim.fn.has('windows')) then
        exe_path = exe_path .. '.exe'
      end

      require('glslView').setup({
          exe_path = exe_path,
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

  -- fuzzy finding
  use {
    'junegunn/fzf.vim',
    requires = {
      {
        'junegunn/fzf',
        run = ':call fzf#install()',
      }
    },
    config = function ()
      -- TODO: use nvim api to define commands
      vim.cmd([[
        command! -bang -nargs=* Rg
          \ call fzf#vim#grep(
          \   'rg --hidden --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
          \   <bang>0 ? fzf#vim#with_preview('up:60%')
          \           : fzf#vim#with_preview('right:50%:hidden', '?'),
          \   <bang>0)
      ]])

      -- 3 FZF bindings:
      --   p -> :Files
      --   ; -> :Buffers
      --   s -> :Rg
      -- 'v' or 'h' can be prepended before the specifier open the file in a vertically or horizontally split
      -- window, respectively.
      local fzf_actions = {
        { 'p', 'Files' },
        { ';', 'Buffers' },
        { 's', 'Rg' },
      }

      for _,v in ipairs(fzf_actions) do
        vim.api.nvim_set_keymap('n', '<leader>' .. v[1], ':' .. v[2] .. '<CR>', { noremap = true });
        vim.api.nvim_set_keymap('n', '<leader>v' .. v[1], ':vsplit: | ' .. v[2] .. '<CR>', { noremap = true });
        vim.api.nvim_set_keymap('n', '<leader>h' .. v[1], ':split: | ' .. v[2] .. '<CR>', { noremap = true });
      end
    end
  }

  -- change directory to the project root while editing files
  use 'airblade/vim-rooter'

  use {
    'dag/vim-fish',
    config = function()
      vim.api.nvim_create_autocmd({ 'FileType' }, {
          pattern = { 'fish' },
          callback = function()
            vim.api.nvim_command('compiler fish')
            vim.opt_local.foldmethod = 'expr'
          end
      })
    end
  }

end)
