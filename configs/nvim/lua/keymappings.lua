-- Map leader to space
vim.g.mapleader = " "

local keymap = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}
local expr_opts = {noremap = true, expr = true, silent = true}

function FixBufHover()
    vim.diagnostic.hide()
    vim.lsp.buf.hover()
    vim.diagnostic.show()
end

require('legendary').setup {
    keymaps = {
        {
            '<c-h>',
            '<c-w>h',
            mode = {'n'},
            description = 'move focus left',
            opts = default_opts
        }, {
            '<c-j>',
            '<c-w>j',
            mode = {'n'},
            description = 'move focus down',
            opts = default_opts
        }, {
            '<c-k>',
            '<c-w>k',
            mode = {'n'},
            description = 'move focus up',
            opts = default_opts
        }, {
            '<c-l>',
            '<c-w>l',
            mode = {'n'},
            description = 'move focus right',
            opts = default_opts
        }, {
            '<',
            '<gv',
            mode = {'v'},
            description = 'unindent selection',
            opts = default_opts
        }, {
            '>',
            '>gv',
            mode = {'v'},
            description = 'indent selection',
            opts = default_opts
        }, {
            'Y',
            'y$',
            mode = {'n'},
            description = 'yank to end of line',
            opts = default_opts
        }, {
            'p',
            '"_dP',
            mode = {'v'},
            description = 'paste over selected text',
            opts = default_opts
        }, {
            'n',
            'nzz',
            mode = {'n'},
            description = 'next result (center)',
            opts = default_opts
        }, {
            'N',
            'Nzz',
            mode = {'n'},
            description = 'previous result (center)',
            opts = default_opts
        }, {
            '<ESC>',
            ':nohlsearch<bar>:echo<cr>',
            mode = {'n'},
            description = 'cancel search highlight',
            opts = default_opts
        }, {
            'J',
            [[:m '>+1<cr>gv-gc]],
            mode = {'v'},
            description = 'move lines downward',
            opts = default_opts
        }, {
            'K',
            [[:m '<-2<cr>gv-gc]],
            mode = {'v'},
            description = 'move lines upward',
            opts = default_opts
        }, {
            'j',
            "v:count == 0 ? 'gj' : 'j'",
            mode = {'n'},
            description = 'move down accross visual lines',
            opts = expr_opts
        }, {
            'k',
            "v:count == 0 ? 'gk' : 'k'",
            mode = {'n'},
            description = 'move down accross visual lines',
            opts = expr_opts
        }, {
            'jk',
            '<esc>',
            mode = {'i'},
            description = 'leave insert mode',
            opts = default_opts
        }, {
            'jk',
            '<c-\\><c-n>',
            mode = {'t'},
            description = 'leave insert mode (in terminal)',
            opts = default_opts
        }, {
            '<s-h>',
            ':bprevious<cr>',
            mode = {'n'},
            description = 'next buffer',
            opts = default_opts
        }, {
            '<s-l>',
            ':bnext<cr>',
            mode = {'n'},
            description = 'prev buffer',
            opts = default_opts
        }
    },
    autocmds = {
        {
            'FileType',
            'set commentstring=//%s',
            opts = {pattern = {'*.c, *.cpp'}},
            description = 'set commentstrings for C and C++ to // instead of block comments'
        }, {
            'TextYankPost',
            'lua vim.highlight.on_yank {on_visual = false}',
            description = 'highlight yanked text'
        }, {
            'CursorHold',
            'lua vim.diagnostic.open_float(nil, { focusable = false })',
            description = 'open diagnostics on holding the cursor'
        }, {
            {'BufNewFile', 'BufRead'},
            'set filetype=fsharp',
            opts = {pattern = {'*.fs', '*.fs{x,i}'}},
            description = 'set filetype to fsharp for *.{fs,fsx,fsi} files'
        }, {
            {'BufNewFile', 'BufRead'},
            'set filetype=astro',
            opts = {pattern = {'*.astro'}},
            description = 'set filetype to astro for *.astro files'
        }

    }
}

require('which-key').register({
    w = {
        name = "save",
        w = {'<cmd>update!<cr>', 'force update'},
        q = {'<cmd>wq<cr>', 'save and quit'},
        a = {'<cmd>wqa<cr>', 'save and quit all'}
    },
    q = {
        name = "quit",
        q = {'<cmd>q<cr>', 'quit'},
        f = {'<cmd>q!<cr>', 'force quit'},
        a = {'<cmd>qa!<cr>', 'force quit all'}
    },

    J = {'<cmd>resize -2<cr>', 'resize down'},
    K = {'<cmd>resize +2<cr>', 'resize up'},
    H = {'<cmd>vertical resize -2<cr>', 'resize left'},
    L = {'<cmd>vertical resize +2<cr>', 'resize right'},

    -- buffer control
    b = {
        name = 'Buffer',
        c = {'<cmd>bd!<cr>', 'Close current buffer'},
        q = {'<cmd>%bd|e#|bd#<cr>', 'Delete all buffers, but current'},
        Q = {'<cmd>%bd|e#|bd#<cr>', 'Delete all buffers'},
        s = {'<cmd>JABSOpen<cr>', 'Open JABS'},
        x = 'JABS: horizontal split',
        v = 'JABS: vertical split',
        ['<c-d>'] = 'JABS: close buffer',
        ['<s-p>'] = 'JABS: open buffer preview'
    },

    -- git
    g = {name = 'Git', g = {'<cmd>Neogit<cr>', 'open neogit'}},

    -- telescope
    f = {
        name = 'Telescope',
        b = {
            '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'buffer fuzzy find'
        },
        f = {'<cmd>Telescope find_files hidden=true<cr>', 'file finder'},
        g = {'<cmd>Telescope live_grep<cr>', 'live grep'},
        h = {'<cmd>Telescope notify<cr>', 'notify history browser'},
        n = {'<cmd>Telescope file_browser<cr>', 'file browser'},
        p = {'<cmd>Telescope projects<cr>', 'projects browser'},
        t = {
            [[:lua require('telescope').extensions.git_worktree.git_worktrees()<cr>]],
            'git worktrees'
        }
    },

    -- LSP
    l = {
        name = 'Lsp',
        ['['] = {'<cmd>lua vim.lso.buf.definition()<cr>', 'definition'},
        [']'] = {'<cmd>lua vim.lso.buf.declaration()<cr>', 'declaration'},
        ['{'] = {'<cmd>lua FixBufHover()<cr>', 'buffer hover'},
        ['}'] = {'<cmd>lua vim.lsp.buf.implementation()<cr>', 'implementation'},
        ['rr'] = {'<cmd>lua vim.lsp.buf.references()<cr>', 'references'},
        ['rn'] = {'<cmd>lua vim.lsp.buf.rename()<cr>', 'rename'},
        ['ca'] = {'<cmd>lua vim.lsp.buf.code_action()<cr>', 'code action'},
        ['sh'] = {
            '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>',
            'show line diagnostics'
        },
        n = {
            '<cmd>lua vim.diagnostic.goto_next()<cr>',
            'go to next warning/error'
        },
        N = {
            '<cmd>lua vim.diagnostic.goto_prev()<cr>',
            'go to prev warning/error'
        },
        s = {
            '<cmd>source ~/.config/nvim/lua/settings.lua<cr>',
            'source nvim/settings.lua'
        },
        -- Trouble
        t = {
            name = 'Trouble',
            t = {'<cmd>TroubleToggle<cr>', 'toggle trouble'},
            w = {
                '<cmd>TroubleToggle workspace_diagnostics<cr>',
                'toggle trouble workspace_diagnostics'
            },
            d = {
                '<cmd>TroubleToggle document_diagnostics<cr>',
                'toggle trouble document_diagnostics'
            },
            l = {'<cmd>TroubleToggle loclist<cr>', 'toggle trouble loclist'},
            q = {'<cmd>TroubleToggle quickfix<cr>', 'toggle trouble quickfix'},
            r = {
                '<cmd>TroubleToggle lsp_references<cr>',
                'toggle trouble lsp_references'
            }
        }
    },

    -- neogen
    n = {"<cmd>lua require('neogen').generate()<cr>", 'generate doc'},

    -- file explorer
    p = {
        name = 'File explorer',
        v = {
            '<cmd>Neotree filesystem reveal float<cr>', 'file browser as float'
        },
        p = {
            '<cmd>Neotree filesystem reveal left<cr>',
            'file browser on the left'
        }
    },

    -- refactoring
    r = {
        name = "refactoring.nvim",
        r = {
            "<esc><cmd>lua require('telescope').extensions.refactoring.refactors()<cr>",
            'open in telescope'
        },
        e = {
            "<esc><cmd>lua require('refactoring').refactor('Extract Function')<cr>",
            'extract function'
        },
        f = {
            "<esc><cmd>lua require('refactoring').refactor('Extract Function to file')<cr>",
            'extract function to file'
        },
        v = {
            "<esc><cmd>lua require('refactoring').refactor('Extract Variable')<cr>",
            'extract variable'
        },
        i = {
            "<esc><cmd>lua require('refactoring').refactor('Inline Variable')<cr>",
            'inline variable'
        },
        b = {
            "<cmd>lua require('refactoring').refactor('Extract Block')<cr>",
            'extract block'
        },
        n = {
            "<cmd>lua require('refactoring').refactor('Extract Block To File')<cr>",
            'extract block to file'
        },
        p = {
            "<cmd>lua require('refactoring').debug.printf({below = false})<cr>",
            'add print statement'
        },
        d = {
            "<cmd>lua require('refactoring').debug.print_var({})<cr>",
            'add print statement for selected var'
        },
        c = {
            "<cmd>lua require('refactoring').debug.cleanup({})<cr>",
            'clean up debug statements'
        }
    },

    -- Spectre
    s = {
        name = 'Spectre',
        s = {[[:lua require('spectre').open()<cr>]], 'open spectre'},
        v = {
            [[:lua require('spectre').open_visual()<cr>]],
            'open spectre on visual selection'
        },
        f = {
            [[:lua require('spectre').open_file_search()<cr>]],
            'open spectre file search'
        }
    },

    t = {
        name = "neotest",
        a = {"<cmd>lua require('neotest').run.attach()<cr>", "Attach"},
        f = {
            "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
            "Run File"
        },
        F = {
            "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
            "Debug File"
        },
        l = {"<cmd>lua require('neotest').run.run_last()<cr>", "Run Last"},
        L = {
            "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>",
            "Debug Last"
        },
        n = {"<cmd>lua require('neotest').run.run()<cr>", "Run Nearest"},
        N = {
            "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
            "Debug Nearest"
        },
        o = {
            "<cmd>lua require('neotest').output.open({ enter = true })<cr>",
            "Output"
        },
        q = {"<cmd>lua require('neotest').run.stop()<cr>", "Stop"},
        s = {"<cmd>lua require('neotest').summary.toggle()<cr>", "Summary"}
    },

    -- Packer
    z = {
        name = 'Packer',
        c = {'<cmd>PackerCompile<cr>', 'compile'},
        i = {'<cmd>PackerInstall<cr>', 'install'},
        s = {'<cmd>PackerSync<cr>', 'sync'},
        S = {'<cmd>PackerStatus<cr>', 'status'},
        u = {'<cmd>PackerUpdate<cr>', 'update'}
    }
}, {
    mode = 'n',
    prefix = '<leader>',
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false
})
