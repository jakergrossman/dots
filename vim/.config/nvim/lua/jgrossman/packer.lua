--vim.cmd.packadd "packer.nvim"

return require("packer").startup(function(use)
    -- packer can manage itself
    use "wbthomason/packer.nvim"

    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.1",
        requires = "nvim-lua/plenary.nvim"
    }

    use {
        "ahmedkhalf/project.nvim",
        after = "telescope.nvim",
        config = function()
            require("project_nvim").setup {
                exclude_dirs = { "~/.config/nvim/*" }
            }
        end
    }

    use {
        "folke/tokyonight.nvim",
        config = function()
            vim.opt.background = "dark"
            vim.cmd.colorscheme "tokyonight-night"
        end
    }

    -- treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    use "nvim-treesitter/playground"

    use "tpope/vim-commentary"
    use "tpope/vim-fugitive"
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
end)
