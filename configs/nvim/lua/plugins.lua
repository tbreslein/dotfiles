require("paq")({
	"savq/paq-nvim",

	-- deps
	"nvim-lua/plenary.nvim", -- for almost every plugin
	"kyazdani42/nvim-web-devicons",

	-- UI
	"sainnhe/gruvbox-material",
	"nvim-lualine/lualine.nvim",
	"romgrk/barbar.nvim",
	"folke/zen-mode.nvim",

	{
		"nvim-treesitter/nvim-treesitter",
		run = function()
			vim.cmd("TSUpdate")
		end,
	},

	-- movement
	"ggandor/leap.nvim",
	"theprimeagen/harpoon",
	"nvim-telescope/telescope.nvim",
	"elihunter173/dirbuf.nvim",

	-- editing
	"numToStr/Comment.nvim",
	"windwp/nvim-ts-autotag",
	"mbbill/undotree",
	"gpanders/editorconfig.nvim",

	-- languages
	"vmchale/just-vim",
	"simrat39/rust-tools.nvim",

	-- LSP
	"jose-elias-alvarez/null-ls.nvim",
	"rubixdev/mason-update-all",

	-- LSP zero
	"VonHeikemen/lsp-zero.nvim",
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",
})
