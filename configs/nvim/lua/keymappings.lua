-- Map leader to space
vim.g.mapleader = " "

local utils = require('utils')
local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

function FixBufHover()
    vim.diagnostic.hide()
    vim.lsp.buf.hover()
    vim.diagnostic.show()
end

require('legendary').setup{
    keymaps = {
        { '<c-h>', '<c-w>h', mode = { 'n' }, description = 'move focus left', opts = default_opts },
        { '<c-j>', '<c-w>j', mode = { 'n' }, description = 'move focus down', opts = default_opts },
        { '<c-k>', '<c-w>k', mode = { 'n' }, description = 'move focus up', opts = default_opts },
        { '<c-l>', '<c-w>l', mode = { 'n' }, description = 'move focus right', opts = default_opts },

        { '<', '<gv', mode = { 'v' }, description = 'unindent', opts = default_opts },
        { '>', '>gv', mode = { 'v' }, description = 'indent', opts = default_opts },

        { 'Y', 'y$',  mode = { 'n' }, description = 'yank to end of line', opts = default_opts },
        { 'p', '"_dP', mode = { 'v' }, description = 'paste over selected text', opts = default_opts },

        { 'n',     'nzz',                        mode = { 'n' }, description = 'next result (center)', opts = default_opts },
        { 'N',     'Nzz',                        mode = { 'n' }, description = 'previous result (center)', opts = default_opts },
        { '<ESC>', ':nohlsearch<bar>:echo<cr>',  mode = { 'n' }, description = 'cancel search highlight', opts = default_opts },

        { 'J', [[:m '>+1<cr>gv-gc]], mode = { 'v' }, description = 'move lines downward', opts = default_opts },
        { 'K', [[:m '<-2<cr>gv-gc]], mode = { 'v' }, description = 'move lines upward', opts = default_opts },

        { 'j', "v:count == 0 ? 'gj' : 'j'",  mode = { 'n' }, description = 'move down accross visual lines', opts = expr_opts },
        { 'k', "v:count == 0 ? 'gk' : 'k'",  mode = { 'n' }, description = 'move down accross visual lines', opts = expr_opts },

        { 'jk', '<esc>',        mode = { 'i' }, description = 'leave insert mode', opts = default_opts },
        { 'jk', '<c-\\><c-n>',  mode = { 't' }, description = 'leave insert mode (in terminal)', opts = default_opts },

        { '<s-h>', ':bprevious<cr>', mode = { 'n' }, description = 'next buffer', opts = default_opts },
        { '<s-l>', ':bnext<cr>',     mode = { 'n' }, description = 'prev buffer', opts = default_opts },
    },
    augroups = {
        {
            name = 'fmt',
            clear = true,
            {
                'BufWritePre',
                'undojoin | silent! Neoformat',
                description = 'silent Neoformat on an undo',
            },
        }
    },
    autocmds = {
        {
            'FileType',
            'set commentstring=//%s',
            opts = { pattern = { '*.c, *.cpp' } },
            description = 'set commentstrings for C and C++ to // instead of block comments',
        },
        {
            'TextYankPost',
            'lua vim.highlight.on_yank {on_visual = false}',
            description = 'highlight yanked text',
        },
        {
            'CursorHold',
            'lua vim.diagnostic.open_float(nil, { focusable = false })',
            description = 'open diagnostics on holding the cursor',
        },
        {
            'BufWritePre',
            'Neoformat prettier',
            opts = { pattern = { '*.{ts,tsx,js,jsx,md,json,html}' } },
            description = 'run Neoformat prettier upon saving a *.{ts,tsx,js,jsx} file',
        },
        {
            'BufWritePre',
            'Neoformat clangformat',
            opts = { pattern = { '*.{c,cpp,hpp}' } },
            description = 'run Neoformat clangformat upon saving a *.{c,cpp,hpp} file',
        },
        {
            'BufWritePre',
            'Neoformat nixpkgs-fmt',
            opts = { pattern = { '*.nix' } },
            description = 'run Neoformat clangformat upon saving a *.{c,cpp,hpp} file',
        },
        {
            'BufWritePre',
            'Neoformat stylish-haskell',
            opts = { pattern = { '*.hs' } },
            description = 'run Neoformat clangformat upon saving a *.{c,cpp,hpp} file',
        },
        {
            'BufWritePre',
            'Neoformat cmake-format',
            opts = { pattern = { 'CMakeLists.txt' } },
            description = 'run Neoformat clangformat upon saving a *.{c,cpp,hpp} file',
        },
        {
            'BufWritePre',
            'Neoformat rustfmt',
            opts = { pattern = { '*.rs' } },
            description = 'run Neoformat clangformat upon saving a *.{c,cpp,hpp} file',
        },
        {
            { 'BufNewFile', 'BufRead' },
            'set filetype=fsharp',
            opts = { pattern = { '*.fs', '*.fs{x,i}' } },
            description = 'set filetype to fsharp for *.{fs,fsx,fsi} files',
        },
        {
            { 'BufNewFile', 'BufRead' },
            'set filetype=astro',
            opts = { pattern = { '*.astro' } },
            description = 'set filetype to astro for *.astro files',
        },

    },
}

require('which-key').register(
    {
        ['w'] = { '<cmd>update!<cr>', 'force save' },
        ['q'] = { '<cmd>q!<CR>', 'force quit' },
        ['e'] = { '<cmd>wq<CR>', 'save and quit' },

        ['J'] = { '<cmd>resize -2<cr>', 'resize down' },
        ['K'] = { '<cmd>resize +2<cr>', 'resize up' },
        ['H'] = { '<cmd>vertical resize -2<cr>', 'resize left' },
        ['L'] = { '<cmd>vertical resize +2<cr>', 'resize right' },

        -- buffer control
        b = {
            name = 'Buffer',
            c = { '<cmd>bd!<cr>', 'Close current buffer' },
            q = { '<cmd>%bd|e#|bd#<cr>', 'Delete all buffers, but current' },
            Q = { '<cmd>%bd|e#|bd#<cr>', 'Delete all buffers' },
            s = { '<cmd>JABSOpen<cr>', 'Open JABS' },
            x = 'JABS: horizontal split',
            v = 'JABS: vertical split',
            ['<c-d>'] = 'JABS: close buffer',
            ['<s-p>'] = 'JABS: open buffer preview',
        },

        -- git
        g = {
            name = 'Git',
            g = { '<cmd>LazyGit<cr>', 'open lazygit' },
        },

        -- telescope
        f = {
            name = 'Telescope',
            f = { '<cmd>Telescope find_files hidden=true<cr>', 'file finder' },
            g = { '<cmd>Telescope live_grep<cr>', 'live grep' },
            b = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'buffer fuzzy find' },
            n = { '<cmd>Telescope file_browser<cr>', 'file browser' },
            h = { '<cmd>Telescope notify<cr>', 'notify history browser' },
            t = { [[:lua require('telescope').extensions.git_worktree.git_worktrees()<cr>]], 'git worktrees' },
        },

        -- file explorer
        p = {
            name = 'File explorer',
            v = { '<cmd>Telescope file_browser<cr>', 'file browser' },
        },

        -- Spectre
        s = {
            name = 'Spectre',
            s = { [[:lua require('spectre').open()<cr>]], 'open spectre' },
            v = { [[:lua require('spectre').open_visual()<cr>]], 'open spectre on visual selection' },
            f = { [[:lua require('spectre').open_file_search()<cr>]], 'open spectre file search' },
        },

        -- Trouble
        t = {
            name = 'Trouble',
            t = { '<cmd>TroubleToggle<cr>',  'toggle trouble'},
            w = { '<cmd>TroubleToggle workspace_diagnostics<cr>',  'toggle trouble workspace_diagnostics'},
            d = { '<cmd>TroubleToggle document_diagnostics<cr>',  'toggle trouble document_diagnostics'},
            l = { '<cmd>TroubleToggle loclist<cr>',  'toggle trouble loclist'},
            q = { '<cmd>TroubleToggle quickfix<cr>',  'toggle trouble quickfix'},
            r = { '<cmd>TroubleToggle lsp_references<cr>',  'toggle trouble lsp_references'},
        },

        -- Packer
        z = {
            name = 'Packer',
            c = { '<cmd>PackerCompile<cr>', 'compile' },
            i = { '<cmd>PackerInstall<cr>', 'install' },
            s = { '<cmd>PackerSync<cr>', 'sync' },
            S = { '<cmd>PackerStatus<cr>', 'status' },
            u = { '<cmd>PackerUpdate<cr>', 'update' },
        },

        -- LSP
        l = {
            name = 'Lsp',
            ['['] =  { '<cmd>lua vim.lso.buf.definition()<cr>',                   'definition' },
            [']'] =  { '<cmd>lua vim.lso.buf.declaration()<cr>',                  'declaration' },
            ['{'] =  { '<cmd>lua FixBufHover()<cr>',                              'buffer hover' },
            ['}'] =  { '<cmd>lua vim.lsp.buf.implementation()<cr>',               'implementation' },
            ['rr'] = { '<cmd>lua vim.lsp.buf.references()<cr>',                   'references' },
            ['rn'] = { '<cmd>lua vim.lsp.buf.rename()<cr>',                       'rename' },
            ['ca'] = { '<cmd>lua vim.lsp.buf.code_action()<cr>',                  'code action' },
            ['sh'] = { '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', 'show line diagnostics' },
            n =      { '<cmd>lua vim.diagnostic.goto_next()<cr>',                 'go to next warning/error' },
            N =      { '<cmd>lua vim.diagnostic.goto_prev()<cr>',                 'go to prev warning/error' },
            s =      { '<cmd>source ~/.config/nvim/lua/settings.lua<cr>',         'source nvim/settings.lua' },
        }
    },
    {
        mode = 'n',
        prefix = '<leader>',
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = false
    }
)

