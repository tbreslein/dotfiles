vim.g.mapleader = " "

-- indentation
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- yank to end of line
vim.keymap.set("n", "Y", "yg$")

-- move visual blocks
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

-- do not move cursor when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- center cursor vertically after jumping with c-d and c-u, and after seach jumps
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- don't lose register when pasting
vim.keymap.set("v", "P", '"_dP')

-- yank to system clipboards (need to be followed up with motions!)
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d')

-- who actually needs Q?
vim.keymap.set("n", "Q", "<nop>")

-- nav through error and quickfix list
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- search and replace the word under the cursor
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- leave insert mode inside terminal mode
vim.keymap.set("t", "jk", "<c-\\><c-n>")

-- plugin keymaps
-- barbar
vim.keymap.set("n", "<leader>,", "<cmd>BufferPrevious<cr>")
vim.keymap.set("n", "<leader>.", "<cmd>BufferNext<cr>")
vim.keymap.set("n", "<leader>x", "<cmd>BufferClose<cr>")

-- zenmode
vim.keymap.set("n", "<leader>zz", function()
	require("zen-mode").toggle()
	vim.wo.wrap = false
end)

-- harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
vim.keymap.set("n", "<C-1>", function()
	ui.nav_file(1)
end)
vim.keymap.set("n", "<C-2>", function()
	ui.nav_file(2)
end)
vim.keymap.set("n", "<C-3>", function()
	ui.nav_file(3)
end)
vim.keymap.set("n", "<C-4>", function()
	ui.nav_file(4)
end)
vim.keymap.set("n", "<C-5>", function()
	ui.nav_file(5)
end)

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<leader>pg", builtin.git_files, {})
vim.keymap.set("n", "<leader>pg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>pb", builtin.live_grep, {})

-- dirbuf
vim.keymap.set("n", "<leader>pv", "<cmd>Dirbuf<cr>")

-- leap
require("leap").add_default_mappings()

-- undotree
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>")

-- trouble
vim.keymap.set("n", "<leader>t", "<cmd>TroubleToggle<cr>")
