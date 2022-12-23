local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
	{
		"epwalsh/obsidian.nvim",
		config = function()
			require("obsidian").setup({
				dir = "~/MEGA/obsidian-vault",
				completion = { nvim_cmp = true },
			})
		end,
	},
	-- UI
	{
		"sainnhe/gruvbox-material",
		config = function()
			vim.o.termguicolors = true
			vim.o.background = "dark"
			vim.g.gruvbox_material_background = "medium"
			vim.g.gruvbox_material_palette = "material"
			vim.g.gruvbox_material_enable_italic = 1
			vim.g.gruvbox_material_enable_bold = 1
			vim.g.gruvbox_material_transparent_background = 1
			vim.g.gruvbox_material_sign_column_background = "none"
			vim.cmd("colorscheme gruvbox-material")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					globalstatus = true,
					theme = "gruvbox-material",
					component_separators = "",
					section_separators = "",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
	{
		"romgrk/barbar.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
	},
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
				window = {
					width = 140,
					options = {
						number = true,
						relativenumber = true,
					},
				},
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			vim.cmd("TSUpdate")
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"help",
					"javascript",
					"typescript",
					"tsx",
					"css",
					"html",
					"astro",
					"json",
					"toml",
					"yaml",
					"bash",
					"gitignore",
					"haskell",
					"go",
					"python",
					"c",
					"cpp",
					"meson",
					"cmake",
					"make",
					"markdown",
					"nix",
					"lua",
					"rust",
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				autotag = {
					enable = true,
				},
			})
		end,
	},

	-- movement
	"ggandor/leap.nvim",
	{
		"theprimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	"elihunter173/dirbuf.nvim",

	-- editing
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({})
		end,
	},
	"windwp/nvim-ts-autotag",
	"mbbill/undotree",
	"gpanders/editorconfig.nvim",

	-- languages
	"vmchale/just-vim",
	"simrat39/rust-tools.nvim",
	{
		"simrat39/rust-tools.nvim",
		config = function()
			require("rust-tools").setup({ tools = { inlay_hints = { only_current_line = true } } })
		end,
	},

	-- LSP
	"jose-elias-alvarez/null-ls.nvim",
	"rubixdev/mason-update-all",
	{
		"folke/trouble.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("trouble").setup({})
		end,
	},

	-- LSP zero
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-cmdline",
			"amarakon/nvim-cmp-lua-latex-symbols",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
	},
})
