return {
    {
       "TimUntersberger/neogit",
       dependencies = {
           "nvim-lua/plenary.nvim",
           "sindrets/diffview.nvim"
       },
        config = function()
            local ok, git = pcall(require, "neogit")
            if not ok then
              return
            end

            git.setup {
              integrations = {
                diffview = true
              }
            }
        end,
        keys = {
            { "<leader>do", function() vim.cmd("DiffviewOpen") end },
            { "<leader>dc", function() vim.cmd("DiffviewClose") end },
            { "<leader>gs", function() require("neogit").open() end },
        },
    },
    "airblade/vim-gitgutter",
}
