local harpoon = require("harpoon")

harpoon:setup()

local nmap = require("jgrossman.map").nmap

require("telescope").load_extension("harpoon")

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

nmap { "<leader>a", function() harpoon:list():append() end }
nmap { "<C-e>", function() ui.toggle_quick_menu(harpoon:list()) end }

nmap { "<C-h>", function() ui.nav_file(1) end }
nmap { "<C-t>", function() ui.nav_file(2) end }
nmap { "<C-n>", function() ui.nav_file(3) end }
nmap { "<C-s>", function() ui.nav_file(4) end }
