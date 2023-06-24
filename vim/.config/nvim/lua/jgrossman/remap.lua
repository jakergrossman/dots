vim.g.mapleader = " "

local nmap = require("jgrossman.map").nmap
local imap = require("jgrossman.map").imap
local vmap = require("jgrossman.map").vmap
local xmap = require("jgrossman.map").xmap

nmap { "<leader>pv", vim.cmd.Ex }

-- move visual selection through file by line
vmap { "J", ":m '>+1<CR>gv=gv" }
vmap { "K", ":m '<-2<CR>gv=gv" }

-- when joining lines, keep cursor where it is
nmap { "J", "mzJ`z" }

-- make <C-d> and <C-u> keep cursor in center for better orientation
nmap { "<C-d>", "<C-d>zz" }
nmap { "<C-u>", "<C-u>zz" }

-- make n and N keep cursor in center
nmap { "n", "nzzzv" }
nmap { "N", "Nzzzv" }

-- "put" over visual selection and preserve register (don't yank deleted text)
xmap { "<leader>p", "\"_dP" }

-- yank to system clipboard
nmap { "<leader>y", "\"+y" }
vmap { "<leader>y", "\"+y" }

-- don't ever press capital Q, it's the worst place in the universe
nmap { "Q", "<nop>" }

-- quickfix navigation
nmap { "<C-j>", "<cmd>cprev<CR>zz" }
nmap { "<C-k>", "<cmd>cnext<CR>zz" }

-- quick replace word under cursor
nmap { "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>" }

nmap { "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>" }
