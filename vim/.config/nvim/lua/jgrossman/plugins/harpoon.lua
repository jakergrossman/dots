local function on_attach()
    local conf = require("telescope.config").values

    local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
        end

        require("telescope.pickers").new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
                results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
        }):find()
    end

    local harpoon = require("harpoon")
    harpoon:setup()

    local nmap = require("jgrossman.map").nmap

    nmap { "<leader>a", function() harpoon:list():append() end }
    nmap { "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end }

    nmap { "<C-h>", function() harpoon:list():select(1) end }
    nmap { "<C-t>", function() harpoon:list():select(2) end }
    nmap { "<C-n>", function() harpoon:list():select(3) end }
    nmap { "<C-s>", function() harpoon:list():select(4) end }

    nmap { "<leader>ph", function() toggle_telescope(harpoon:list()) end }
end

return {
    {
        "ThePrimeagen/harpoon",
        branch="harpoon2",
        dependencies=
        {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        },
        config=on_attach,
    }
}
