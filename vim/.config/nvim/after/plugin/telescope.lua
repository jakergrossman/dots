local ok, telescope = pcall(require, "telescope")
if not ok then
    return
end

local builtin = require("telescope.builtin")

local nmap = require("jgrossman.map").nmap

nmap { "<leader>pf", builtin.find_files }
nmap { "<leader>pg", builtin.live_grep }
nmap { "<C-p>", builtin.git_files }

telescope.setup {
    pickers = {
        find_files = {
            hidden = true
        }
    },

    defaults = {
        file_ignore_patterns = {
            "^.git/.*",
            "^.svn/.*",
            "^build/.*"
        }
    }
}
