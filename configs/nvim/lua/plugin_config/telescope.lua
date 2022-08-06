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

