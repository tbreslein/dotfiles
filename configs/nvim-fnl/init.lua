-- bootstrap paq
local paq_path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if vim.fn.empty(vim.fn.glob(paq_path)) > 0 then
    vim.fn.system {
        'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git',
        paq_path
    }
end
vim.cmd [[packadd paq-nvim]]

-- bootstrap hotpot
local hotpot_path = vim.fn.stdpath('data') ..
                        '/site/pack/paqs/start/hotpot.nvim'

if vim.fn.empty(vim.fn.glob(hotpot_path)) > 0 then
    print("Could not find hotpot.nvim, cloning new copy to", hotpot_path)
    vim.fn.system({
        'git', 'clone', 'https://github.com/rktjmp/hotpot.nvim', hotpot_path
    })
    vim.cmd("helptags " .. hotpot_path .. "/doc")
end

-- Enable fnl/ support
require("hotpot")

local indent = 4

vim.o.termguicolors = true
vim.o.background = 'dark'

vim.g.gruvbox_material_background = 'medium'
vim.g.gruvbox_material_palette = 'material'
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_transparent_background = 1
vim.g.gruvbox_material_sign_column_background = 'none'

vim.g.tokyonight_style = 'night'
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_dark_sidebar = false
vim.g.tokyonight_dark_float = false

vim.cmd([[colorscheme gruvbox-material]])
-- vim.cmd([[colorscheme tokyonight]])
-- vim.cmd [[colorscheme poimandres]]

vim.cmd 'syntax enable'
vim.cmd 'filetype plugin indent on'
vim.b.expandtab = true
vim.b.shiftwidth = indent
vim.b.tabstop = indent
vim.b.autoindent = true
vim.b.smartindent = true
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.scrolloff = 5
vim.o.shiftround = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.clipboard = 'unnamed,unnamedplus'
vim.o.conceallevel = 0
vim.o.encoding = 'utf-8'
vim.o.hlsearch = true
vim.o.showmatch = true
vim.o.showmode = false
vim.o.cursorline = true
vim.o.guicursor = 'a:block'
vim.w.number = true
vim.w.relativenumber = true
vim.w.cc = '120'
vim.o.ruler = true
vim.o.signcolumn = 'yes'
vim.o.laststatus = 2
vim.o.pumheight = 10
vim.o.showtabline = 2
vim.o.timeoutlen = 300
vim.o.completeopt = "menuone,noselect"
vim.opt.listchars:append("eol:↴")

-- folding
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Now you can load fennel code, so you could put the rest of your
-- config in a separate `~/.config/nvim/fnl/my_config.fnl` or
-- `~/.config/nvim/fnl/plugins.fnl`, etc.
require("config")
