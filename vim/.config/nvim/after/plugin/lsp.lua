local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed {
    "tsserver",
    "eslint",
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

local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings {
    ["<CR>"] = cmp.config.disable,
    ["<Tab>"] = cmp.config.disable,
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
}

lsp.setup_nvim_cmp {
    mapping = cmp_mappings
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
    local bindopts = {buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bindopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bindopts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bindopts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bindopts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, bindopts)

    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bindopts)
    vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references, bindopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bindopts)
end)


lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
