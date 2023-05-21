require("telescope").load_extension("projects")

local builtin = require('telescope.builtin')
local ext = require("telescope").extensions

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pp', ext.projects.projects, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
