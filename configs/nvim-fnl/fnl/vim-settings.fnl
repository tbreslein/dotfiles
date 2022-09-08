(require-macros :hibiscus.vim))
(import-macros {: plugin-setup} :util-macros)

;; ----
;; MISC
;; ----
(exec [[:filetype :plugin :indent :on]])
(set vim.opt.encoding :utf-8)

;; ------
;; COLORS
;; ------
(set vim.o.termguicolors true)
(set vim.o.background :dark)

(set vim.g.gruvbox_material_background :medium)
(set vim.g.gruvbox_material_palette :material)
(set vim.g.gruvbox_material_enable_italic 1)
(set vim.g.gruvbox_material_enable_bold 1)
(set vim.g.gruvbox_material_transparent_background 1)
(set vim.g.gruvbox_material_sign_column_background :none)

(plugin-setup :poimandres
              {:bold_vert_slit true
               :dim_nc_background true
               :disable_background true
               :disable_float_background false})

(color! :poimandres)

;; -------
;; EDITING
;; -------
(set vim.opt.shiftwidth 4)
(set vim.opt.tabstop 4)
(set vim.g.mapleader " ")
(set vim.opt.autoindent true)
(set vim.opt.expandtab true)
(set vim.opt.smartindent true)
(set vim.opt.clipboard "unnamed,unnamedplus")
(set vim.opt.timeoutlen 300)
(set vim.opt.splitbelow true)
(set vim.opt.splitright true)
(set vim.opt.hlsearch true)
(set vim.opt.shiftround true)
(set vim.opt.laststatus 2)
(set vim.opt.pumheight 10)

;; --
;; UI
;; --
(set vim.wo.colorcolumn '120')
(set vim.opt.cursorline true)
(set vim.wo.number true)
(set vim.wo.relativenumber true)
(set vim.opt.guicursor 'a:block')
(set vim.opt.showmatch true)
(set vim.opt.showmode false)
(set vim.opt.ignorecase true)
(set vim.opt.smartcase true)
(set vim.opt.hidden true)
(set vim.opt.signcolumn 'yes')
(set+ listchars "eol:↴")

;; -------
;; FOLDING
;; -------
(set vim.opt.conceallevel 0)
(set vim.opt.foldcolumn "1")
(set vim.opt.foldlevel 99)
(set vim.opt.foldlevelstart 99)
(set vim.opt.foldenable true)
