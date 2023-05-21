local options = {
    -- line numbers
    number = true,

    -- default 4-wide soft tabs (may be overridden)
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,

    -- always show statusline w/ line number
    laststatus = 2,
    ruler = true,

    -- "natural" split directions
    splitright = true,
    splitbelow = true,

    -- incremental search that doesn't leave highlight
    hlsearch = false,
    incsearch = true,

    -- line length with color column at &textwidth
    textwidth = 120,
    colorcolumn = "+0",

    smartindent = true,

    swapfile = false,
    backup = false,
    undodir = os.getenv("HOME") .. "/.vim/undodir",
    undofile = true,

    wrap = false,

    scrolloff = 8,
    signcolumn = "yes",

    updatetime = 50,
}

-- take action!
for k,v in pairs(options) do
    vim.opt[k] = v
end
