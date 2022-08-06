-- Map leader to space
vim.g.mapleader = " "

-- shorthands
--local fn = vim.fn
--local execute = vim.api.nvim_command

-- auto install packer.nvim if it does not exist
--local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
--if fn.empty(fn.glob(install_path)) > 0 then
--    --execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
--end
--vim.cmd [[packadd packer.nvim]]

-- Auto compile when there are changes in plugins.lua
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'

-- load stuff in lua/
require('plugins')
require('settings')
require('keymappings')
require('lsp_lua')
require('config')
require('plugin_config')

-- some autocommands
-- fix undo history when using neoformat on save
vim.cmd[[
augroup fmt
    autocmd!
    autocmd BufWritePre * undojoin | silent! Neoformat
augroup END
]]
vim.cmd 'autocmd BufWritePre *.{ts,tsx,js,jsx} Neoformat prettier'
vim.cmd 'autocmd BufWritePre *.{cpp,hpp} Neoformat clangformat'
vim.cmd 'autocmd BufNewFile,BufRead *.{fs,fsx,fsi} set filetype=fsharp'
vim.cmd 'autocmd BufNewFile,BufRead *.astro set filetype=astro'

-- rustfmt is handled by rust.vim
vim.cmd 'let g:rustfmt_autosave = 1'

