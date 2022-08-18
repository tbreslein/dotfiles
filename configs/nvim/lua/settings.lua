local utils = require('utils')

local indent = 4

utils.opt('o', 'termguicolors', true)
vim.o.background = 'dark'

vim.g.gruvbox_material_background = 'medium'
vim.g.gruvbox_material_palette = 'original'
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_transparent_background = 1
vim.g.gruvbox_material_sign_column_background = 'none'

vim.g.tokyonight_style = 'night'
vim.g.tokyonight_transparent = true

-- vim.cmd([[colorscheme gruvbox-material]])
vim.cmd([[colorscheme tokyonight]])
-- vim.cmd [[colorscheme poimandres]]


vim.cmd 'syntax enable'
vim.cmd 'filetype plugin indent on'
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
utils.opt('w', 'cc', '120')
utils.opt('o', 'ruler', true)
utils.opt('o', 'signcolumn', 'yes')
utils.opt('o', 'laststatus', 2)
utils.opt('o', 'pumheight', 10)
utils.opt('o', 'showtabline', 2)
utils.opt('o', 'timeoutlen', 300)
vim.o.completeopt = "menuone,noselect"
vim.opt.listchars:append("eol:↴")
vim.notify = require('notify')

-- neoformat
vim.cmd[[ let g:neoformat_try_node_exe = 1 ]]

-- rustfmt is handled by rust.vim
vim.cmd 'let g:rustfmt_autosave = 1'

-- barbar
vim.cmd[[ let bufferline = get(g:, 'bufferline', {}) ]]
vim.cmd[[ let bufferline.animation = v:false ]]

-- editorconfig
vim.cmd[[ let g:EditorConfig_exclude_patterns = ['fugitive://.*'] ]]

-- telescope
require('telescope').load_extension('git_worktree')
require('telescope').load_extension('file_browser')
require('telescope').load_extension('notify')

local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        mappings = {
            n = {
                ['<C-x>'] = actions.select_horizontal,
                ['<C-v>'] = actions.select_vertical,
                ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                ['<C-c>'] = actions.close,
            },
            i = {
                ['<C-x>'] = actions.select_horizontal,
                ['<C-v>'] = actions.select_vertical,
                ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                ['<C-c>'] = actions.close,
            },
        },
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden'
        },
        file_ignore_patterns = { 'node_modules/.*', '.git/.*', '_site/.*' },
        sorting_strategy = 'ascending',
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
        layout_config = {
            vertical = {
                mirror = true,
            },
        },
    },
}

-- luasnip
local ls = require('luasnip')
ls.snippets = {
    all = {
    },

    cpp = {
        ls.parser.parse_snippet(
            "fd",
            "/**\n * @brief $0\n *\n */\nauto $1($2) -> $3;\n"
        ),
        ls.parser.parse_snippet(
            "fi",
            "auto $1($2) -> $3\n{\n    $0\n}\n"
        ),
        ls.parser.parse_snippet(
            "fs",
            "/**\n * @brief $4\n *\n */\nstatic auto $1($2) -> $3\n{\n    $0\n}\n"
        ),
    },

    typescriptreact = {
        ls.parser.parse_snippet(
            "fc",
            "interface $1Props {}\n\nconst $1: React.FC<$1Props> = (props) {\n  return <></>;\n}\n\nexport default $1"
        )
    }
}
