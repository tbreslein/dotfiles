require('telescope').load_extension('notify')

-- Misc
vim.cmd('filetype plugin indent on')
vim.opt.encoding = "utf-8"

-- themeing
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.gruvbox_material_background = "medium"
vim.g.gruvbox_material_palette = "material"
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_transparent_background = 1
vim.g.gruvbox_material_sign_column_background = "none"
vim.cmd("colorscheme gruvbox-material")

-- editing
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.g.mapleader = " "
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.clipboard = "unnamed,unnamedplus"
vim.opt.timeoutlen = 300
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.hlsearch = true
vim.opt.shiftround = false
vim.opt.laststatus = 2
vim.opt.pumheight = 10

-- UI
vim.wo.colorcolumn = "120"
vim.opt.cursorline = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.guicursor = "a:block"
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hidden = true
vim.opt.signcolumn = "yes"
(vim.opt.listchars):append("eol:\226\134\180")

-- Folding
vim.opt.conceallevel = 0
vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
