local utils = require('utils')

utils.opt('o', 'termguicolors', true)
vim.o.background = 'dark'

vim.g.gruvbox_material_background = 'medium'
vim.g.gruvbox_material_palette = 'original'
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_transparent_background = 1
vim.g.gruvbox_material_sign_column_background = 'none'

vim.cmd([[colorscheme gruvbox-material]])

