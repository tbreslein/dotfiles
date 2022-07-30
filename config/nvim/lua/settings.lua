local utils = require('utils')

local cmd = vim.cmd
local indent = 4

cmd 'syntax enable'
cmd 'filetype plugin indent on'
utils.opt('b', 'expandtab', true)
utils.opt('b', 'shiftwidth', indent)
utils.opt('b', 'tabstop', indent)
utils.opt('b', 'autoindent', true)
utils.opt('b', 'smartindent', true)
utils.opt('o', 'hidden', true)
utils.opt('o', 'ignorecase', true)
utils.opt('o', 'smartcase', true)
utils.opt('o', 'scrolloff', 5)
utils.opt('o', 'shiftround', true)
utils.opt('o', 'splitbelow', true)
utils.opt('o', 'splitright', true)
utils.opt('o', 'clipboard', 'unnamed,unnamedplus')
utils.opt('o', 'conceallevel', 0)
utils.opt('o', 'encoding', 'utf-8')
utils.opt('o', 'hlsearch', true)
utils.opt('o', 'showmatch', true)
utils.opt('o', 'showmode', false)
utils.opt('o', 'cursorline', true)
utils.opt('o', 'guicursor', 'a:block')
utils.opt('w', 'number', true)
utils.opt('w', 'relativenumber', true)
utils.opt('w', 'cc', '100')
utils.opt('o', 'textwidth', 100)
utils.opt('o', 'ruler', true)
utils.opt('o', 'signcolumn', 'yes')
utils.opt('o', 'laststatus', 2)
utils.opt('o', 'pumheight', 10)
utils.opt('o', 'showtabline', 2)
vim.o.completeopt = "menuone,noselect"
vim.opt.listchars:append("eol:↴")

-- Highlight on yank
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'

-- override c/c++ commentstring
vim.cmd([[autocmd FileType cpp set commentstring=//%s]])
vim.cmd([[autocmd FileType c set commentstring=//%s]])

-- fix open floats on hover
vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })]])


