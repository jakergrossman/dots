local ok
local lsp
local snip

ok, lsp = pcall(require, "lsp-zero")
if not ok then
    return
end

ok, snip = pcall(require, "luasnip")
if not ok then
    return
end

local nmap = require("jgrossman.map").nmap
local imap = require("jgrossman.map").imap

lsp.preset("recommended")

lsp.ensure_installed {
    "lua_ls",
    "rust_analyzer",
    "clangd",
}

lsp.configure("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
})

lsp.configure("clangd", {
    cmd = {
        "clangd",
        "--query-driver=/usr/bin/arm-none-eabi-*"
    }
})

local cmp = require("cmp")
local cmp_mappings = lsp.defaults.cmp_mappings {
    ["<CR>"] = cmp.config.disable,
    ["<Tab>"] = cmp.config.disable,
    ["<C-n>"] = cmp.mapping(function() snip.jump(1) end, { 'i', 'c' }),
    ["<C-p>"] = cmp.mapping(function() snip.jump(-1) end, { 'i', 'c' }),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
}

lsp.setup_nvim_cmp {
    mapping = cmp_mappings,
    formatting = {
        fields = { "abbr", "menu", "kind" },
        format = function(entry, item)
            -- Define menu shorthand for different completion sources.
            local menu_icon = {
                nvim_lsp = "LSP",
                nvim_lua = "LUA",
                luasnip  = "SNP",
                buffer   = "BUF",
                path     = "PATH",
            }
            -- Set the menu "icon" to the shorthand for each completion source.
            item.menu = menu_icon[entry.source.name]

            -- Set the fixed width of the completion menu to 60 characters.
            local fixed_width = 40

            -- Get the completion entry text shown in the completion window.
            local content = item.abbr

            -- Set the fixed completion window width.
            if fixed_width then
                vim.o.pumwidth = fixed_width
            end

            -- Get the width of the current window.
            local win_width = vim.api.nvim_win_get_width(0)

            -- Set the max content width based on either: 'fixed_width'
            -- or a percentage of the window width, in this case 20%.
            -- We subtract 10 from 'fixed_width' to leave room for 'kind' fields.
            local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

            -- Truncate the completion entry text if it's longer than the
            -- max content width. We subtract 3 from the max content width
            -- to account for the "..." that will be appended to it.
            if #content > max_content_width then
                item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
            else
                item.abbr = content .. (" "):rep(max_content_width - #content)
            end
            return item
        end
    }
}

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I',
    }
})

lsp.on_attach(function(_, bufnr)
    local bindopts = { buffer = bufnr, remap = false }

    nmap { "gd", vim.lsp.buf.definition, bindopts }
    nmap { "K", vim.lsp.buf.hover, bindopts }
    nmap { "[d", vim.diagnostic.goto_prev, bindopts }
    nmap { "]d", vim.diagnostic.goto_next, bindopts }
    imap { "<C-h>", vim.lsp.buf.signature_help, bindopts }

    nmap { "<leader>ca", vim.lsp.buf.code_action, bindopts }
    nmap { "<leader>rr", vim.lsp.buf.references, bindopts }
    nmap { "<leader>rn", vim.lsp.buf.rename, bindopts }

    nmap { "<leader>ff", vim.lsp.buf.format, bindopts }
end)


lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
