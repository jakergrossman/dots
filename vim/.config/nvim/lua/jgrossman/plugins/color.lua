return {
    {
        "sainnhe/sonokai",
        config = function()

            vim.o.list = true

            -- U+00B7 = "Middle Dot"
            -- U+00BB = "Right-Pointing Double Angle Quotation Mark"
            vim.o.listchars = "space:\u{00B7},tab:\u{00BB} "
        end,
    },
	{
		"jmckiern/vim-shoot",
		build = '"./install.py" geckodriver',
	},
	{
		"sapegin/squirrelsong",
		dir = "~/projects/squirrelsong",
		config = function(plugin)
			vim.opt.rtp:append(plugin.dir .. "/light/Neovim")
		end,
	},
	"blazkowolf/gruber-darker.nvim",
	{
		'Verf/deepwhite.nvim',
		dir = "~/projects/deepwhite.nvim/",
		opts = {
			low_blue_light = false,
			color_overrides = {
				['@lsp.type.variable.c'] = { bg = "#FAD4D4" },
				['@lsp.type.parameter.c'] = { bg = "#FAD4D4" },
				['@function.call.c'] = { bg = "#EDD4FA" },
				['@lsp.type.function.c'] = { bg = "#EDD4FA" },
				Whitespace = { fg = "#CCCBC6" },
			},
		},
	},
}
