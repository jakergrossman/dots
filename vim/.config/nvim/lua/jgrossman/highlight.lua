local Jake_Highlight = vim.api.nvim_create_augroup("Jake_Highlight", {})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = Jake_Highlight,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank { timeout = 300 }
    end
})

vim.cmd[[colorscheme deepwhite]]
