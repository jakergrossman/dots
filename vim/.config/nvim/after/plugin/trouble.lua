local ok, trouble = pcall(require, "trouble")
if not ok then
    return
end

local nmap = require("jgrossman.map").nmap

nmap { "<leader>tt", function() vim.cmd "TroubleToggle" end }

trouble.setup {
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
