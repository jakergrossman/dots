return require("packer").startup(function(use)
    -- packer can manage itself
    use "wbthomason/packer.nvim"

    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.1",
        requires = "nvim-lua/plenary.nvim"
    }

    use {
        "EdenEast/nightfox.nvim",
        config = function()
            vim.opt.background = "light"
            vim.cmd.colorscheme "dawnfox"
        end
    }

    -- treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    use "nvim-treesitter/playground"

    use "tpope/vim-commentary"
    -- use "tpope/vim-fugitive"
    use {
        "TimUntersberger/neogit",
        requires = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim"
        }
    }
    use "airblade/vim-gitgutter"
    use "mbbill/undotree"

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }

    use "ThePrimeagen/harpoon"
    use "folke/trouble.nvim"
    use "github/copilot.vim"
end)
