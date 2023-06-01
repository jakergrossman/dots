vim.keymap.set("n", "<leader>tt", "<cmd>TroubleToggle<cr>")

require("trouble").setup {
    icons = false,
    fold_open = "v",
    fold_closed = ">",
    indent_lines = false,
    signs = {
        error = "error",
        warning = "warn",
        hint = "hint",
        information = "info",
    },
    use_diagnostic_signs = false,
}
