local function on_attach()

    local ok, telescope = pcall(require, "telescope")
    if not ok then
        return
    end

    local builtin = require("telescope.builtin")

    local nmap = require("jgrossman.map").nmap

    nmap { "<leader>pf", builtin.find_files }
    nmap { "<leader>pg", builtin.live_grep }
    nmap { "<C-p>", builtin.git_files }

    telescope.setup({
        pickers = {
            find_files = {
                hidden = true
            }
        },

        layout_config = {
            horizontal = {
                preview_cutoff = 100,
                preview_width = 0.5,
            },
        },

        defaults = {
            file_ignore_patterns = {
                "^.git/.*",
                "^.svn/.*",
                "^build/.*",
                ".vim/undodir"
            }
        }
    })

end

return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            {
                "<leader>pf",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.find_files()
                end
            },
            {
                "<leader>pbf",
                function()
                    local builtin = require("telescope.builtin")
                    local utils = require("telescope.utils")
                    builtin.find_files({ cwd = utils.buffer_dir() })
                end
            },
            {
                "<leader>pg",
                function()
                    require("telescope.builtin").live_grep()
                end
            },
            {
                "<leader>pbg",
                function()
                    local builtin = require("telescope.builtin")
                    local utils = require("telescope.utils")
                    builtin.live_grep({ cwd = utils.buffer_dir() })
                end
            },
            { "<C-p>", function() require("telescope.builtin").git_files() end },
        },
        config = on_attach,
    },
}
