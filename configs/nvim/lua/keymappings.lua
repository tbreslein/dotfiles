local utils = require('utils')
require('telescope').load_extension('git_worktree')

function FixBufHover()
    vim.diagnostic.hide()
    vim.lsp.buf.hover()
    vim.diagnostic.show()
end

utils.map('n', '<C-h>', '<C-w>h')
utils.map('n', '<C-j>', '<C-w>j')
utils.map('n', '<C-k>', '<C-w>k')
utils.map('n', '<C-l>', '<C-w>l')
utils.map('n', '<Leader>j', '<cmd>resize -2<CR>')
utils.map('n', '<Leader>k', '<cmd>resize +2<CR>')
utils.map('n', '<Leader>h', '<cmd>vertical resize -2<CR>')
utils.map('n', '<Leader>l', '<cmd>vertical resize +2<CR>')
utils.map('n', '<Tab>', '<cmd>tabnext<CR>')
utils.map('n', '<S-Tab>', '<cmd>tabprevious<CR>')
utils.map('n', '<C-s>', '<cmd>w<CR>')
utils.map('n', '<Leader>m', '<cmd>nohlsearch<CR>')
utils.map('v', '<', '<gv')
utils.map('v', '>', '>gv')
utils.map('n', 'Y', 'y$', { noremap = true })
-- utils.map('n', '<leader>pv', [[:Ex<CR>]], { noremap = true, silent = true })
utils.map('n', '<leader>pv', [[:NnnPicker<CR>]], { noremap = true, silent = true })
utils.map('n', '<leader>pp', [[:NnnExplorer<CR>]], { noremap = true, silent = true })

-- moving lines
utils.map('v', 'J', [[:m '>+1<CR>gv=gv]], { noremap = true })
utils.map('v', 'K', [[:m '>-2<CR>gv=gv]], { noremap = true })
utils.map('n', '<leader>j', [[:m .+1<CR>==]], { noremap = true })
utils.map('n', '<leader>k', [[:m .-2<CR>==]], { noremap = true })

-- plugins
utils.map('n', '<Leader>gg', '<cmd>LazyGit<CR>', { noremap = false })

-- barbar
-- move to previous/next
utils.map('n', '<A-h>', '<cmd>:BufferPrevious<CR>', { noremap = true, silent = true })
utils.map('n', '<A-l>', '<cmd>:BufferNext<CR>', { noremap = true, silent = true })

-- re-order to previous/next
utils.map('n', '<A-H>', '<cmd>:BufferMovePrevious<CR>', { noremap = true, silent = true })
utils.map('n', '<A-L>', '<cmd>:BufferMoveNext<CR>', { noremap = true, silent = true })

-- goto buffer in position...
utils.map('n', '<A-1>', '<cmd>:BufferGoto 1<CR>', { noremap = true, silent = true })
utils.map('n', '<A-2>', '<cmd>:BufferGoto 2<CR>', { noremap = true, silent = true })
utils.map('n', '<A-3>', '<cmd>:BufferGoto 3<CR>', { noremap = true, silent = true })
utils.map('n', '<A-4>', '<cmd>:BufferGoto 4<CR>', { noremap = true, silent = true })
utils.map('n', '<A-5>', '<cmd>:BufferGoto 5<CR>', { noremap = true, silent = true })
utils.map('n', '<A-6>', '<cmd>:BufferGoto 6<CR>', { noremap = true, silent = true })
utils.map('n', '<A-7>', '<cmd>:BufferGoto 7<CR>', { noremap = true, silent = true })
utils.map('n', '<A-8>', '<cmd>:BufferGoto 8<CR>', { noremap = true, silent = true })
utils.map('n', '<A-9>', '<cmd>:BufferGoto 9<CR>', { noremap = true, silent = true })

-- close buffer
utils.map('n', '<A-q>', '<cmd>:BufferClose<CR>', { noremap = true, silent = true })
utils.map('n', '<A-o>', '<cmd>:BufferCloseAllButCurrent<CR>', { noremap = true, silent = true })

-- pick buffer
utils.map('n', '<A-s>', '<cmd>:BufferPick<CR>', { noremap = true, silent = true })

-- Telescope
utils.map('n', '<Leader>ff', '<cmd>:Telescope find_files hidden=true<CR>',
    { noremap = true, silent = true })
utils.map('n', '<Leader>fg', '<cmd>:Telescope live_grep<CR>', { noremap = true, silent = true })
utils.map('n', '<Leader>fb', '<cmd>:Telescope current_buffer_fuzzy_find<CR>',
    { noremap = true, silent = true })
utils.map('n', '<Leader>fn', '<cmd>:Telescope file_browser<CR>', { noremap = true, silent = true })
utils.map('n', '<Leader>ft', [[ :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>]])

-- Spectre
utils.map('n', '<Leader>S', [[ :lua require('spectre').open()<CR> ]])
utils.map('n', '<Leader>sv', [[ :lua require('spectre').open_visual()<CR> ]])
utils.map('n', '<Leader>sf', [[ :lua require('spectre').open_file_search()<CR> ]])

-- trouble
utils.map('n', '<Leader>tt', "<cmd>TroubleToggle<CR>", { silent = true, noremap = true })
utils.map('n', '<Leader>tw', "<cmd>TroubleToggle workspace_diagnostics<CR>", { silent = true, noremap = true })
utils.map('n', '<Leader>td', "<cmd>TroubleToggle document_diagnostics<CR>", { silent = true, noremap = true })
utils.map('n', '<Leader>tl', "<cmd>TroubleToggle loclist<CR>", { silent = true, noremap = true })
utils.map('n', '<Leader>tq', "<cmd>TroubleToggle quickfix<CR>", { silent = true, noremap = true })
utils.map('n', '<Leader>tr', "<cmd>TroubleToggle lsp_references<CR>", { silent = true, noremap = true })

-- LSP
local opts = { noremap=true, silent=true }
utils.map('n', '<Leader>[',  [[ <cmd>lua vim.lsp.buf.definition()<CR> ]], opts)
utils.map('n', '<Leader>]',  [[ <cmd>lua vim.lsp.buf.declaration()<CR> ]], opts)
utils.map('n', '<Leader>{',  [[ <cmd>lua FixBufHover()<CR> ]], opts)
utils.map('n', '<Leader>}',  [[ <cmd>lua vim.lsp.buf.implementation()<CR> ]], opts)
utils.map('n', '<Leader>lrr',  [[ <cmd>lua vim.lsp.buf.references()<CR> ]], opts)
utils.map('n', '<Leader>lrn',  [[ <cmd>lua vim.lsp.buf.rename()<CR> ]], opts)
utils.map('n', '<Leader>lca', [[ <cmd>lua vim.lsp.buf.code_action()<CR> ]], opts)
utils.map('n', '<Leader>lsh', [[ <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR> ]], opts)
utils.map('n', '<Leader>ln',  [[ <cmd>lua vim.diagnostic.goto_next()<CR> ]], opts)

-- luasnip
utils.map('n', '<Leader><Leader>s', [[ <cmd>source ~/.config/nvim/lua/config/luasnip.lua<CR> ]])

