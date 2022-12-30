function map(mode, lhs, rhs, ops)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- toggle between 120 and 80 character textwidth
vim.api.nvim_create_user_command(
    'ToggleTextWidth',
    function()
        if vim.o.textwidth == 120 then
            vim.o.textwidth = 80
        else
            vim.o.textwidth = 120
        end
        vim.o.colorcolumn = vim.o.textwidth .. ''
    end,
    { nargs = 0 }
)
map('n', '<leader>w', ':ToggleTextWidth<CR>')
