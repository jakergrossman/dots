local ok, git = pcall(require, "neogit")
if not ok then
  return
end

local nmap = require("jgrossman.map").nmap

nmap { "<leader>do", function() vim.cmd("DiffviewOpen") end }
nmap { "<leader>dc", function() vim.cmd("DiffviewClose") end }
nmap { "<leader>gs", git.open }

git.setup {
  integrations = {
    diffview = true
  }
}

