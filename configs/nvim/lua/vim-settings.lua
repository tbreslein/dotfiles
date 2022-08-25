-------
-- MISC
-------
--vim.cmd 'syntax enable'
vim.cmd 'filetype plugin indent on'
vim.opt.encoding = 'utf-8'

---------
-- COLORS
---------
vim.o.termguicolors = true
vim.o.background = 'dark'

vim.g.gruvbox_material_background = 'medium'
vim.g.gruvbox_material_palette = 'material'
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_transparent_background = 1
vim.g.gruvbox_material_sign_column_background = 'none'

vim.cmd 'colorscheme gruvbox-material'

----------
-- EDITING
----------
local indent = 4
vim.opt.shiftwidth = indent
vim.opt.tabstop = indent
vim.g.mapleader = ' '
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.clipboard = 'unnamed,unnamedplus'
vim.opt.timeoutlen = 300
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.hlsearch = true
vim.opt.shiftround = true
vim.opt.laststatus = 2
vim.opt.pumheight = 10
--vim.opt.completeopt = "menuone,noselect"

-----
-- UI
-----
vim.wo.colorcolumn = '120'
vim.opt.cursorline = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.guicursor = 'a:block'
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hidden = true
vim.opt.signcolumn = 'yes'
vim.opt.listchars:append("eol:↴")
--vim.opt.showtabline = 2

----------
-- FOLDING
----------
vim.opt.conceallevel = 0
vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

