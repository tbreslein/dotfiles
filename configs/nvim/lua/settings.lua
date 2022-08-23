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

-- notify
vim.notify = require('notify')
-- telescope
require('telescope').load_extension('git_worktree')
require('telescope').load_extension('file_browser')
require('telescope').load_extension('notify')
require('telescope').load_extension('refactoring')
require('telescope').load_extension('projects')

local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        mappings = {
            n = {
                ['<C-x>'] = actions.select_horizontal,
                ['<C-v>'] = actions.select_vertical,
                ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                ['<C-c>'] = actions.close
            },
            i = {
                ['<C-x>'] = actions.select_horizontal,
                ['<C-v>'] = actions.select_vertical,
                ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                ['<C-c>'] = actions.close
            }
        },
        vimgrep_arguments = {
            'rg', '--color=never', '--with-filename', '--line-number',
            '--column', '--smart-case', '--hidden'
        },
        file_ignore_patterns = {'node_modules/.*', '.git/.*', '_site/.*'},
        sorting_strategy = 'ascending',
        set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
        layout_config = {vertical = {mirror = true}}
    }
}

-- luasnip
local ls = require('luasnip')
ls.snippets = {
    all = {},

    cpp = {
        ls.parser.parse_snippet("fd",
                                "/**\n * @brief $0\n *\n */\nauto $1($2) -> $3;\n"),
        ls.parser.parse_snippet("fi", "auto $1($2) -> $3\n{\n    $0\n}\n"),
        ls.parser.parse_snippet("fs",
                                "/**\n * @brief $4\n *\n */\nstatic auto $1($2) -> $3\n{\n    $0\n}\n")
    },

    typescriptreact = {
        ls.parser.parse_snippet("fc",
                                "interface $1Props {}\n\nconst $1: React.FC<$1Props> = (props) {\n  return <></>;\n}\n\nexport default $1")
    }
}
