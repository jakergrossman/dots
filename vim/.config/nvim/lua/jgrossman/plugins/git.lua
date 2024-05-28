return {
    {
        "TimUntersberger/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim"
        },
        config = true,
        keys = {
            { "<leader>do", function() vim.cmd("DiffviewOpen") end },
            { "<leader>dc", function() vim.cmd("DiffviewClose") end },
            { "<leader>gs", function() require("neogit").open() end },
        },
    },
    "airblade/vim-gitgutter",
}
