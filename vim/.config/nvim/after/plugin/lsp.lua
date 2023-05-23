local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed {
    "tsserver",
    "eslint",
    "lua_ls",
    "rust_analyzer",
    "clangd",
}


require('lspconfig').lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
}


local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings {
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<TAB>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
}
lsp.setup_nvim_cmp {
    mapping = cmp_mappings
}

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
