local utils = require('utils')

local indent = 4

utils.opt('o', 'termguicolors', true)
vim.o.background = 'dark'

-- vim.g.gruvbox_material_background = 'medium'
-- vim.g.gruvbox_material_palette = 'original'
-- vim.g.gruvbox_material_enable_italic = 1
-- vim.g.gruvbox_material_enable_bold = 1
-- vim.g.gruvbox_material_transparent_background = 1
-- vim.g.gruvbox_material_sign_column_background = 'none'
-- cmd([[colorscheme gruvbox-material]])

vim.g.tokyonight_style = 'night'
vim.g.tokyonight_transparent = true
vim.cmd([[colorscheme tokyonight]])


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
utils.opt('o', 'winbar', '%f')
vim.o.completeopt = "menuone,noselect"
vim.opt.listchars:append("eol:↴")

-- Highlight on yank
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'

-- override c/c++ commentstring
vim.cmd([[autocmd FileType cpp set commentstring=//%s]])
vim.cmd([[autocmd FileType c set commentstring=//%s]])

-- fix open floats on hover
vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })]])

-- neoformat
vim.cmd[[ let g:neoformat_try_node_exe = 1 ]]

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

-- barbar
vim.cmd[[ let bufferline = get(g:, 'bufferline', {}) ]]
vim.cmd[[ let bufferline.animation = v:false ]]

-- editorconfig
vim.cmd[[ let g:EditorConfig_exclude_patterns = ['fugitive://.*'] ]]

-- telescope
local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        mappings = {
            n = {
                ['<c-x>'] = false,
                ['<c-s>'] = actions.select_horizontal,
                ['<c-q>'] = actions.send_to_qflist + actions.open_qflist,
                ['<c-c>'] = actions.close,
            },
            i = {
                ['<c-x>'] = false,
                ['<c-s>'] = actions.select_horizontal,
                ['<c-q>'] = actions.send_to_qflist + actions.open_qflist,
                ['<c-c>'] = actions.close,
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
