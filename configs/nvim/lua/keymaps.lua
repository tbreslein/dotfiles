vim.g.mapleader = " "
require("leap").add_default_mappings({})
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }
local keymaps = {
  {
    mode = { "n" },
    description = "move focus left",
    opts = default_opts,
    "<c-h>",
    "<c-w>h"
  }, {
    mode = { "n" },
    description = "move focus down",
    opts = default_opts,
    "<c-j>",
    "<c-w>j"
  }, {
    mode = { "n" },
    description = "move focus up",
    opts = default_opts,
    "<c-k>",
    "<c-w>k"
  }, {
    mode = { "n" },
    description = "move focus right",
    opts = default_opts,
    "<c-l>",
    "<c-w>l"
  }, {
    mode = { "v" },
    description = "unindent selection",
    opts = default_opts,
    "<",
    "<gv"
  }, {
    mode = { "v" },
    description = "indent selection",
    opts = default_opts,
    ">",
    ">gv"
  }, {
    mode = { "n" },
    description = "yank to end of line",
    opts = default_opts,
    "Y",
    "y$"
  }, {
    mode = { "v" },
    description = "paste over selected text",
    opts = default_opts,
    "P", "_dP"
  }, {
    mode = { "n" },
    description = "next result (center)",
    opts = default_opts,
    "n",
    "nzzzv"
  }, {
    mode = { "n" },
    description = "prev result (center)",
    opts = default_opts,
    "N",
    "Nzzzv"
  }, {
    mode = { "n" },
    description = "move half page down and recenter",
    opts = default_opts,
    "<c-d>",
    "<c-d>zz"
  }, {
    mode = { "n" },
    description = "move half page up and recenter",
    opts = default_opts,
    "<c-u>",
    "<c-u>zz"
  }, {
    mode = { "n" },
    description = "cancel search highlight",
    opts = default_opts,
    "<esc>",
    ":nohlsearch<bar>:echo<cr>"
  }, {
    mode = { "v" },
    description = "move lines downward",
    opts = default_opts,
    "J",
    ":m '>+1<cr>gv-gc"
  }, {
    mode = { "v" },
    description = "move lines upward",
    opts = default_opts,
    "K",
    ":m '<-2<cr>gv-gc"
  }, {
    mode = { "n" },
    description = "move down accross visual lines",
    opts = expr_opts,
    "j",
    "v:count == 0 ? 'gj' : 'j'"
  }, {
    mode = { "n" },
    description = "move up accross visual lines",
    opts = expr_opts,
    "k",
    "v:count == 0 ? 'gk' : 'k'"
  }, {
    mode = { "t" },
    description = "leave insert mode (terminal)",
    opts = default_opts,
    "jk",
    "<c-\\><c-n>"
  }, {
    mode = { "n" },
    description = "prev buffer",
    opts = default_opts,
    "<a-j>",
    "<cmd>BufferPrevious<cr>"
  }, {
    mode = { "n" },
    description = "next buffer",
    opts = default_opts,
    "<a-k>",
    "<cmd>BufferNext<cr>"
  }, {
    mode = { "n" },
    description = "move buffer prev",
    opts = default_opts,
    "<a-<>",
    "<cmd>BufferMovePrevious<cr>"
  }, {
    mode = { "n" },
    description = "move buffer next",
    opts = default_opts,
    "<a->>",
    "<cmd>BufferMoveNext<cr>"
  }, {
    mode = { "n" },
    description = "close buffer",
    opts = default_opts,
    "<a-x>",
    "<cmd>BufferClose<cr>"
  }
}
local autocmds = {
  {
    opts = { pattern = { "*.c", "*.h", "*.cpp", "*.hpp" } },
    description = "set commentstring for C and C++",
    "FileType",
    "set commentstring=//%s",
  }, {
    description = "highlight yanked text",
    "TextYankPost",
    "lua vim.highlight.on_yank {on_visual = false}",
  }, {
    description = "open diagnostics on holding the cursor",
    "CursorHold",
    "lua vim.diagnostic.open_float(nil, { focusable = false })",
  }, {
    opts = { pattern = { "*.fs", "*.fs{x,i}" } },
    description = "set filetype to fsharp for *.{fs,fsx,fsi} files",
    { "BufNewFile", "BufRead" },
    "set filetype=fsharp",
  }, {
    opts = { pattern = { "*.mdx" } },
    description = "set filetype to markdown for *.mdx",
    { "BufNewFile", "BufRead" },
    "set filetype=markdown"
  }, {
    opts = { pattern = { "*.astro" } },
    description = "set filetype to astro for *.astro",
    { "BufNewFile", "BufRead" },
    "set filetype=astro"
  }
}
require("legendary").setup({ keymaps = keymaps, autocmds = autocmds })

require("which-key").register({
  w = {
    name = "save",
    w = { "<cmd>update!<cr>", "force update" },
    q = { "<cmd>wq<cr>", "save and quit" },
    a = { "<cmd>wqa<cr>", "save and quit all" }
  },
  q = {
    name = "quit",
    q = { "<cmd>q<cr>", "quit" },
    f = { "<cmd>q!<cr>", "force quit" },
    a = { "<cmd>qa!<cr>", "force quit all" }
  },
  J = { "<cmd>resize -2<cr>", "resize down" },
  K = { "<cmd>resize +2<cr>", "resize up" },
  H = { "<cmd>vertical resize -2<cr>", "resize left" },
  L = { "<cmd>vertical resize +2<cr>", "resize right" },
  g = { "<cmd>LazyGit<cr>", "LazyGit" },
  f = {
    name = "Telescope",
    l = { "<cmd>Telescope builtin<cr>", "list builtin pickers" },
    b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "buffer fzf" },
    F = { "<cmd>Telescope git_files hidden=true<cr>", "git ls-files" },
    f = { "<cmd>Telescope find_files hidden=true<cr>", "file finder" },
    g = { "<cmd>Telescope live_grep<cr>", "live grep" },
    h = { "<cmd>Telescope notify<cr>", "notify history" },
    r = { "<cmd>Telescope lsp_references<cr>", "LSP references" },
    D = { "<cmd>Telescope diagnostics<cr>", "LSP diagnostics" },
    i = { "<cmd>Telescope lsp_implementations<cr>", "LSP implementations" },
    d = { "<cmd>Telescope lsp_definitions<cr>", "LSP definitions" },
    t = { "<cmd>Telescope lsp_type_definitions<cr>", "LSP type definitions" }
  },
  l = {
    name = "Lsp",
    D = { vim.lsp.buf.declaration, "declaration" },
    d = { vim.lsp.buf.definitions, "definitions" },
    i = { vim.lsp.buf.implementation, "implementation" },
    r = { vim.lsp.buf.references, "references" },
    n = { vim.lsp.buf.rename, "rename" },
    T = { vim.lsp.buf.type_definition, "type definition" },
    c = { vim.lsp.buf.code_action, "code action" },
    F = { vim.lsp.buf.formatting, "formatting" },
    K = { vim.lsp.buf.hover, "hover" },
    f = { vim.diagnostic.open_float, "float diagnostic" },
    l = { vim.diagnostic.setloclist, "setloclist" },
    q = { vim.diagnostic.goto_prev, "prev diag" },
    e = { vim.diagnostic.goto_next, "next diag" },
    w = {
      name = "workspace",
      a = { vim.lsp.buf.add_workspace_folder, "add workspace folder" },
      r = { vim.lsp.buf.remove_workspace_folder, "remove workspace folder" },
      l = { vim.lsp.buf.list_workspace_folders, "list workspace folders" }
    },
    t = {
      name = "Trouble",
      t = { "<cmd>TroubleToggle<cr>", "toggle trouble" },
      w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "toggle workspace diagnostics" },
      d = { "<cmd>TroubleToggle document_diagnostics<cr>", "toggle document diagnostics" },
      l = { "<cmd>TroubleToggle loclist<cr>", "toggle loclist" },
      q = { "<cmd>TroubleToggle quickfix<cr>", "toggle quickfix" },
      r = { "<cmd>TroubleToggle lsp_references<cr>", "toggle lsp references" }
    }
  },
  p = {
    name = "File explorer",
    v = { "<cmd>Dirbuf<cr>", "dirbuf" },
  },
  r = {
    name = "refactor",
    r = { "<esc><cmd>lua require('telescope').extensions.refactoring.refactors()<cr>", "open refactoring in telescope" },
    e = { "<esc><cmd>lua require('refactoring').refactor('Extract Function')<cr>", "extract function" },
    f = { "<esc><cmd>lua require('refactoring').refactor('Extract Function to file')<cr>", "extract function to file" },
    v = { "<esc><cmd>lua require('refactoring').refactor('Extract Variables')<cr>", "extract variable" },
    i = { "<esc><cmd>lua require('refactoring').refactor('Inline Variables')<cr>", "inline variable" },
    b = { "<esc><cmd>lua require('refactoring').refactor('Extract Block')<cr>", "extract block" },
    n = { "<esc><cmd>lua require('refactoring').refactor('Extract Block to File')<cr>", "extract block to file" },
    p = { "<esc><cmd>lua require('refactoring').debug.printf({below = false})<cr>", "add print statement" },
    d = { "<esc><cmd>lua require('refactoring').debug.print_var()<cr>", "add print statement for selected var" },
    c = { "<esc><cmd>lua require('refactoring').debug.cleanup({})<cr>", "clean up debug statements" }
  },
  s = {
    name = "Spectre",
    s = { ":lua require('spectre').open()<cr>", "open spectre" },
    v = { ":lua require('spectre').open_visual()<cr>", "open spectre on visual selection" },
    f = { ":lua require('spectre').open_file_search()<cr>", "open spectre file search" }
  },
  t = {
    name = "Tabs",
    a = { "<cmd>tabedit<cr>", "new tab" },
    c = { "<cmd>tabclose<cr>", "close tab" },
    o = { "<cmd>tabonly<cr>", "only tab" },
    n = { "<cmd>tabn<cr>", "next tab" },
    p = { "<cmd>tabp<cr>", "prev tab" },
    m = {
      name = "move",
      n = { "<cmd>-tabmove<cr>", "move tab down" },
      p = { "<cmd>+tabmove<cr>", "move tab up" }
    }
  },
  z = {
    name = "Packer",
    s = { "<cmd>PackerSync<cr>", "sync" },
    t = { "<cmd>TSUpdateSync<cr>", "treesitter update sync" }
  }
}, { mode = "n", prefix = "<leader>", buffer = nil, silent = true, noremap = true, nowait = false })
