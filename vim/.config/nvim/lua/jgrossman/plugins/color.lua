return {
    {
        "sainnhe/sonokai",
        config = function()
            vim.cmd.colorscheme "sonokai"

            vim.o.list = true

            -- U+00B7 = "Middle Dot"
            -- U+00BB = "Right-Pointing Double Angle Quotation Mark"
            vim.o.listchars = "space:\u{00B7},tab:\u{00BB} "
        end,
    }
}
