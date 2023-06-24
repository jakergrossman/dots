if not pcall(require, "harpoon") then
  return
end

local nmap = require("jgrossman.map").nmap

require("telescope").load_extension("harpoon")

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

nmap { "<leader>a", mark.add_file }
nmap { "<C-e>", function() vim.cmd "Telescope harpoon marks" end }

nmap { "<C-h>", function() ui.nav_file(1) end }
nmap { "<C-t>", function() ui.nav_file(2) end }
nmap { "<C-n>", function() ui.nav_file(3) end }
nmap { "<C-s>", function() ui.nav_file(4) end }
