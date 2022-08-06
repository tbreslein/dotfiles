{ pkgs, nvimPkg, ... }:

{
  programs.neovim = {
    enable = true;
    package = nvimPkg;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    #   plugins = with pkgs.vimPlugins; [
    #     # themes, colors, UI
    #     gruvbox-material
    #     tokyonight-nvim
    #     nvim-colorizer-lua
    #     nvim-web-devicons # dep for a lot of plugins
    #
    #     # git
    #     lazygit-nvim
    #     git-worktree-nvim
    #     # gh-nvim # not in nixpkgs yet
    #
    #     # text looks
    #     indent-blankline-nvim
    #
    #     # UI
    #     nnn-vim
    #     popup-nvim # telescope ++ spectre dep
    #     plenary-nvim # telescope ++ spectre dep
    #     telescope-nvim
    #     barbar-nvim
    #     lualine-nvim
    #     nvim-spectre
    #     trouble-nvim
    #
    #     # background functionality
    #     vim-rooter
    #
    #     # text functionality
    #     nvim-ts-context-commentstring
    #     comment-nvim
    #     nvim-autopairs
    #     vim-surround
    #     lightspeed-nvim
    #
    #     # languages, syntax
    #     editorconfig-nvim
    #     # neofsharp-vim # not in nixpkgs
    #     rust-vim
    #     vim-toml
    #     nvim-ts-autotag
    #
    #     # treesitter, LSP
    #     nvim-treesitter
    #     cmp-nvim-lsp
    #     cmp-buffer
    #     cmp-path
    #     cmp-cmdline
    #     nvim-cmp
    #     nvim-lspconfig
    #     lsp_signature-nvim
    #     luasnip
    #     cmp_luasnip
    #     neoformat
    #   ];
    #
    #   generatedConfigs = {
    #     lua = ''
    #       ----------------
    #       -- PLUGIN CONFIG
    #       ----------------
    #       require("colorizer").setup {}
    #       require("nnn").setup {}
    #       require("git-worktree").setup {}
    #       require("lualine").setup {
    #           options = {
    #               globalstatus = true,
    #               component_separators = "",
    #               section_separators = "",
    #               theme = "tokyonight",
    #           },
    #           sections = {
    #               lualine_a = {"mode"},
    #               lualine_b = {"branch", "diagnostics"},
    #               lualine_c = {"filename"},
    #               lualine_x = {},
    #               lualine_y = {"progress"},
    #               lualine_z = {"location"}
    #           },
    #       }
    #       require("indent_blankline").setup {
    #           show_end_of_line = true,
    #           show_current_context = true,
    #           show_current_context_start = true,
    #       }
    #       require("Comment").setup {
    #           pre_hook = function(ctx)
    #               -- Only calculate commentstring for tsx filetypes
    #               if vim.bo.filetype == "typescriptreact" then
    #                   local U = require("Comment.utils")
    #
    #                   -- Determine whether to use linewise or blockwise commentstring
    #                   local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"
    #
    #                   -- Determine the location where to calculate commentstring from
    #                   local location = nil
    #                   if ctx.ctype == U.ctype.block then
    #                       location = require("ts_context_commentstring.utils").get_cursor_location()
    #                   elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
    #                       location = require("ts_context_commentstring.utils").get_visual_start_location()
    #                   end
    #                   return require("ts_context_commentstring.internal").calculate_commentstring({
    #                       key = type,
    #                       location = location,
    #                   })
    #               end
    #           end
    #       }
    #       require("nvim-autopairs").setup {}
    #       require("lightspeed").setup { ignore_case = true, }
    #       require("nvim-treesitter.configs").setup {
    #           autotag = { enable = true },
    #           ensure_installed = "all",
    #           highlight = {
    #               enable = true,
    #           },
    #           context_commentstring = {
    #               enable = true,
    #           },
    #       }
    #       require("lsp_signature").setup {}
    #       require("spectre").setup {}
    #       require("trouble").setup {}
    #       local actions = require("telescope.actions")
    #       require("telescope").setup {
    #           defaults = {
    #               mappings = {
    #                   n = {
    #                       ["<c-x>"] = false,
    #                       ["<c-s>"] = actions.select_horizontal,
    #                       ["<c-q>"] = actions.send_to_qflist + actions.open_qflist,
    #                       ["<c-c>"] = actions.close,
    #                   },
    #                   i = {
    #                       ["<c-x>"] = false,
    #                       ["<c-s>"] = actions.select_horizontal,
    #                       ["<c-q>"] = actions.send_to_qflist + actions.open_qflist,
    #                       ["<c-c>"] = actions.close,
    #                   },
    #               },
    #               vimgrep_arguments = {
    #                   "rg",
    #                   "--color=never",
    #                   "--with-filename",
    #                   "--line-number",
    #                   "--column",
    #                   "--smart-case",
    #                   "--hidden"
    #               },
    #               file_ignore_patterns = { "node_modules/.*", ".git/.*", "_site/.*" },
    #               sorting_strategy = "ascending",
    #               set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    #               file_previewer = require"telescope.previewers".vim_buffer_cat.new,
    #               grep_previewer = require"telescope.previewers".vim_buffer_vimgrep.new,
    #               qflist_previewer = require"telescope.previewers".vim_buffer_qflist.new,
    #               layout_config = {
    #                   vertical = {
    #                       mirror = true,
    #                   },
    #               },
    #           },
    #       }
    #
    #       ---------------
    #       -- AUTOCOMMANDS
    #       ---------------
    #       vim.cmd[[
    #           augroup fmt
    #               autocmd!
    #               autocmd BufWritePre * undojoin | silent! Neoformat
    #           augroup END
    #       ]]
    #       vim.cmd "autocmd BufWritePre *.{ts,tsx,js,jsx} Neoformat prettier"
    #       vim.cmd "autocmd BufWritePre *.{cpp,hpp} Neoformat clangformat"
    #       vim.cmd "autocmd BufNewFile,BufRead *.{fs,fsx,fsi} set filetype=fsharp"
    #       vim.cmd "autocmd BufNewFile,BufRead *.astro set filetype=astro"
    #
    #       -- rustfmt is handled by rust.vim
    #       vim.cmd "let g:rustfmt_autosave = 1"
    #
    #       -----------
    #       -- SETTINGS
    #       -----------
    #       local utils = require("utils")
    #
    #       local cmd = vim.cmd
    #       local indent = 4
    #
    #       cmd "syntax enable"
    #       cmd "filetype plugin indent on"
    #       utils.opt("b", "expandtab", true)
    #       utils.opt("b", "shiftwidth", indent)
    #       utils.opt("b", "tabstop", indent)
    #       utils.opt("b", "autoindent", true)
    #       utils.opt("b", "smartindent", true)
    #       utils.opt("o", "hidden", true)
    #       utils.opt("o", "ignorecase", true)
    #       utils.opt("o", "smartcase", true)
    #       utils.opt("o", "scrolloff", 5)
    #       utils.opt("o", "shiftround", true)
    #       utils.opt("o", "splitbelow", true)
    #       utils.opt("o", "splitright", true)
    #       utils.opt("o", "clipboard", "unnamed,unnamedplus")
    #       utils.opt("o", "conceallevel", 0)
    #       utils.opt("o", "encoding", "utf-8")
    #       utils.opt("o", "hlsearch", true)
    #       utils.opt("o", "showmatch", true)
    #       utils.opt("o", "showmode", false)
    #       utils.opt("o", "cursorline", true)
    #       utils.opt("o", "guicursor", "a:block")
    #       utils.opt("w", "number", true)
    #       utils.opt("w", "relativenumber", true)
    #       utils.opt("w", "cc", "100")
    #       utils.opt("o", "textwidth", 100)
    #       utils.opt("o", "ruler", true)
    #       utils.opt("o", "signcolumn", "yes")
    #       utils.opt("o", "laststatus", 2)
    #       utils.opt("o", "pumheight", 10)
    #       utils.opt("o", "showtabline", 2)
    #       utils.opt("o", "winbar", "%f")
    #       vim.o.completeopt = "menuone,noselect"
    #       vim.opt.listchars:append("eol:↴")
    #
    #       -- Highlight on yank
    #       vim.cmd "au TextYankPost * lua vim.highlight.on_yank {on_visual = false}"
    #
    #       -- override c/c++ commentstring
    #       vim.cmd([[autocmd FileType cpp set commentstring=//%s]])
    #       vim.cmd([[autocmd FileType c set commentstring=//%s]])
    #
    #       -- fix open floats on hover
    #       vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })]])
    #
    #       --------------
    #       -- KEYMAPPINGS
    #       --------------
    #       local utils = require("utils")
    #       require("telescope").load_extension("git_worktree")
    #
    #       function FixBufHover()
    #           vim.diagnostic.hide()
    #           vim.lsp.buf.hover()
    #           vim.diagnostic.show()
    #       end
    #
    #       utils.map("n", "<C-h>", "<C-w>h")
    #       utils.map("n", "<C-j>", "<C-w>j")
    #       utils.map("n", "<C-k>", "<C-w>k")
    #       utils.map("n", "<C-l>", "<C-w>l")
    #       utils.map("n", "<Leader>j", "<cmd>resize -2<CR>")
    #       utils.map("n", "<Leader>k", "<cmd>resize +2<CR>")
    #       utils.map("n", "<Leader>h", "<cmd>vertical resize -2<CR>")
    #       utils.map("n", "<Leader>l", "<cmd>vertical resize +2<CR>")
    #       utils.map("n", "<Tab>", "<cmd>tabnext<CR>")
    #       utils.map("n", "<S-Tab>", "<cmd>tabprevious<CR>")
    #       utils.map("n", "<C-s>", "<cmd>w<CR>")
    #       utils.map("n", "<Leader>m", "<cmd>nohlsearch<CR>")
    #       utils.map("v", "<", "<gv")
    #       utils.map("v", ">", ">gv")
    #       utils.map("n", "Y", "y$", { noremap = true })
    #       -- utils.map("n", "<leader>pv", [[:Ex<CR>]], { noremap = true, silent = true })
    #       utils.map("n", "<leader>pv", [[:NnnPicker<CR>]], { noremap = true, silent = true })
    #       utils.map("n", "<leader>pp", [[:NnnExplorer<CR>]], { noremap = true, silent = true })
    #
    #       -- moving lines
    #       utils.map("v", "J", [[:m ">+1<CR>gv=gv]], { noremap = true })
    #       utils.map("v", "K", [[:m ">-2<CR>gv=gv]], { noremap = true })
    #       utils.map("n", "<leader>j", [[:m .+1<CR>==]], { noremap = true })
    #       utils.map("n", "<leader>k", [[:m .-2<CR>==]], { noremap = true })
    #
    #       -- plugins
    #       utils.map("n", "<Leader>gg", "<cmd>LazyGit<CR>", { noremap = false })
    #
    #       -- barbar
    #       -- move to previous/next
    #       utils.map("n", "<A-h>", "<cmd>:BufferPrevious<CR>", { noremap = true, silent = true })
    #       utils.map("n", "<A-l>", "<cmd>:BufferNext<CR>", { noremap = true, silent = true })
    #
    #       -- re-order to previous/next
    #       utils.map("n", "<A-H>", "<cmd>:BufferMovePrevious<CR>", { noremap = true, silent = true })
    #       utils.map("n", "<A-L>", "<cmd>:BufferMoveNext<CR>", { noremap = true, silent = true })
    #
    #       -- goto buffer in position...
    #       utils.map("n", "<A-1>", "<cmd>:BufferGoto 1<CR>", { noremap = true, silent = true })
    #       utils.map("n", "<A-2>", "<cmd>:BufferGoto 2<CR>", { noremap = true, silent = true })
    #       utils.map("n", "<A-3>", "<cmd>:BufferGoto 3<CR>", { noremap = true, silent = true })
    #       utils.map("n", "<A-4>", "<cmd>:BufferGoto 4<CR>", { noremap = true, silent = true })
    #       utils.map("n", "<A-5>", "<cmd>:BufferGoto 5<CR>", { noremap = true, silent = true })
    #       utils.map("n", "<A-6>", "<cmd>:BufferGoto 6<CR>", { noremap = true, silent = true })
    #       utils.map("n", "<A-7>", "<cmd>:BufferGoto 7<CR>", { noremap = true, silent = true })
    #       utils.map("n", "<A-8>", "<cmd>:BufferGoto 8<CR>", { noremap = true, silent = true })
    #       utils.map("n", "<A-9>", "<cmd>:BufferGoto 9<CR>", { noremap = true, silent = true })
    #
    #       -- close buffer
    #       utils.map("n", "<A-q>", "<cmd>:BufferClose<CR>", { noremap = true, silent = true })
    #       utils.map("n", "<A-o>", "<cmd>:BufferCloseAllButCurrent<CR>", { noremap = true, silent = true })
    #
    #       -- pick buffer
    #       utils.map("n", "<A-s>", "<cmd>:BufferPick<CR>", { noremap = true, silent = true })
    #
    #       -- Telescope
    #       utils.map("n", "<Leader>ff", "<cmd>:Telescope find_files hidden=true<CR>",
    #           { noremap = true, silent = true })
    #       utils.map("n", "<Leader>fg", "<cmd>:Telescope live_grep<CR>", { noremap = true, silent = true })
    #       utils.map("n", "<Leader>fb", "<cmd>:Telescope current_buffer_fuzzy_find<CR>",
    #           { noremap = true, silent = true })
    #       utils.map("n", "<Leader>fn", "<cmd>:Telescope file_browser<CR>", { noremap = true, silent = true })
    #       utils.map("n", "<Leader>ft", [[ :lua require("telescope").extensions.git_worktree.git_worktrees()<CR>]])
    #
    #       -- Spectre
    #       utils.map("n", "<Leader>S", [[ :lua require("spectre").open()<CR> ]])
    #       utils.map("n", "<Leader>sv", [[ :lua require("spectre").open_visual()<CR> ]])
    #       utils.map("n", "<Leader>sf", [[ :lua require("spectre").open_file_search()<CR> ]])
    #
    #       -- trouble
    #       utils.map("n", "<Leader>tt", "<cmd>TroubleToggle<CR>", { silent = true, noremap = true })
    #       utils.map("n", "<Leader>tw", "<cmd>TroubleToggle workspace_diagnostics<CR>", { silent = true, noremap = true })
    #       utils.map("n", "<Leader>td", "<cmd>TroubleToggle document_diagnostics<CR>", { silent = true, noremap = true })
    #       utils.map("n", "<Leader>tl", "<cmd>TroubleToggle loclist<CR>", { silent = true, noremap = true })
    #       utils.map("n", "<Leader>tq", "<cmd>TroubleToggle quickfix<CR>", { silent = true, noremap = true })
    #       utils.map("n", "<Leader>tr", "<cmd>TroubleToggle lsp_references<CR>", { silent = true, noremap = true })
    #
    #       -- LSP
    #       local opts = { noremap=true, silent=true }
    #       utils.map("n", "<Leader>[",  [[ <cmd>lua vim.lsp.buf.definition()<CR> ]], opts)
    #       utils.map("n", "<Leader>]",  [[ <cmd>lua vim.lsp.buf.declaration()<CR> ]], opts)
    #       utils.map("n", "<Leader>{",  [[ <cmd>lua FixBufHover()<CR> ]], opts)
    #       utils.map("n", "<Leader>}",  [[ <cmd>lua vim.lsp.buf.implementation()<CR> ]], opts)
    #       utils.map("n", "<Leader>lrr",  [[ <cmd>lua vim.lsp.buf.references()<CR> ]], opts)
    #       utils.map("n", "<Leader>lrn",  [[ <cmd>lua vim.lsp.buf.rename()<CR> ]], opts)
    #       utils.map("n", "<Leader>lca", [[ <cmd>lua vim.lsp.buf.code_action()<CR> ]], opts)
    #       utils.map("n", "<Leader>lsh", [[ <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR> ]], opts)
    #       utils.map("n", "<Leader>ln",  [[ <cmd>lua vim.diagnostic.goto_next()<CR> ]], opts)
    #
    #       -- luasnip
    #       utils.map("n", "<Leader><Leader>s", [[ <cmd>source ~/.config/nvim/lua/config/luasnip.lua<CR> ]])
    #
    #
    #       ------------
    #       -- LSP STUFF
    #       ------------
    #       local on_attach = function(client, bufnr)
    #           local opts = { noremap=true, silent=true }
    #           local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    #           local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    #
    #           -- Set some keybinds conditional on server capabilities
    #           -- if client.resolved_capabilities.document_formatting then
    #           --     buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    #           -- elseif client.resolved_capabilities.document_range_formatting then
    #           --     buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    #           -- end
    #           if client.server_capabilities.document_formatting then
    #               buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    #           elseif client.server_capabilities.document_range_formatting then
    #               buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    #           end
    #
    #           -- Set autocommands conditional on server_capabilities
    #           if client.server_capabilities.document_highlight then
    #               vim.api.nvim_exec([[
    #               hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
    #               hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
    #               hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
    #               augroup lsp_document_highlight
    #               autocmd! * <buffer>
    #               augroup END
    #               ]], false)
    #           end
    #       end
    #
    #       local nvim_lsp = require("lspconfig")
    #       local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
    #       local cmp = require("cmp")
    #       local luasnip = require("luasnip")
    #       local types = require("luasnip.util.types")
    #
    #       luasnip.config.set_config {
    #           -- this tells luasnip to remember to keep around the last snippet.
    #           -- you can jump back into it even if you move outside of the selection.
    #           history = true,
    #
    #           -- enables updating snippets as you type, for dynamic snippets
    #           updateevents = "TextChanged,TextChangedI",
    #
    #           -- Autosnippets
    #           enable_autosnippets = true,
    #
    #           ext_opts = {
    #               [types.choiceNode] = {
    #                   active = {
    #                       virt_text = { { "←", "Error" } }
    #                   }
    #               }
    #           }
    #       }
    #
    #       cmp.setup({
    #           snippet = {
    #               expand = function(args)
    #                   luasnip.lsp_expand(args.body)
    #               end,
    #           },
    #           mapping = {
    #               ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item()),
    #               ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item()),
    #               -- ["<C-n>"] = cmp.mapping(function(fallback)
    #               --     if cmp.visible() then
    #               --         cmp.select_next_item()
    #               --     elseif luasnip.expand_or_jumpable() then
    #               --         luasnip.expand_or_jump()
    #               --     elseif has_words_before() then
    #               --         cmp.complete()
    #               --     else
    #               --         fallback()
    #               --     end
    #               -- end, { "i", "s" }),
    #               --
    #               -- ["<C-p>"] = cmp.mapping(function(fallback)
    #               --     if cmp.visible() then
    #               --         cmp.select_prev_item()
    #               --     elseif luasnip.jumpable(-1) then
    #               --         luasnip.jump(-1)
    #               --     else
    #               --         fallback()
    #               --     end
    #               -- end, { "i", "s" }),
    #
    #               ["<C-k>"] = cmp.mapping(function(fallback)
    #                   if luasnip.expand_or_jumpable() then
    #                       luasnip.expand_or_jump()
    #                   end
    #               end, { "i", "s" }),
    #               ["<C-j>"] = cmp.mapping(function(fallback)
    #                   if luasnip.jumpable(-1) then
    #                       luasnip.jump(-1)
    #                   end
    #               end, { "i", "s" }),
    #               ["<C-l>"] = cmp.mapping(function(fallback)
    #                   if luasnip.choice_active() then
    #                       luasnip.change_choice(1)
    #                   end
    #               end),
    #
    #               ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c"}),
    #               ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    #               ["<C-Space>"] = cmp.mapping.complete(),
    #               ["<C-e>"] = cmp.mapping.close(),
    #               ["<C-i>"] = cmp.mapping.confirm({ select = true }),
    #               -- ["<Tab>"] = cmp.mapping(function(fallback)
    #               --     if cmp.visible() then
    #               --         cmp.select_next_item())
    #           },
    #           sources = cmp.config.sources({
    #               { name = "nvim_lsp" },
    #               { name = "luasnip" },
    #           }, {
    #               { name = "buffer" },
    #           }),
    #       })
    #
    #       cmp.setup.cmdline("/", {
    #           sources = {
    #               { name = "buffer" }
    #           }
    #       })
    #
    #       cmp.setup.cmdline(":", {
    #           sources = cmp.config.sources({
    #               { name = "path" }
    #           }, {
    #               { name = "cmdline" }
    #           })
    #       })
    #
    #       -- Code actions
    #       -- capabilities.textDocument.codeAction = {
    #       --     dynamicRegistration = false;
    #       --     codeActionLiteralSupport = {
    #       --         codeActionKind = {
    #       --             valueSet = {
    #       --                 "",
    #       --                 "quickfix",
    #       --                 "refactor",
    #       --                 "refactor.extract",
    #       --                 "refactor.inline",
    #       --                 "refactor.rewrite",
    #       --                 "source",
    #       --                 "source.organizeImports",
    #       --             };
    #       --         };
    #       --     };
    #       -- }
    #
    #       -- Snippets
    #       -- capabilities.textDocument.completion.completionItem.snippetSupport = true;
    #
    #       capabilities.textDocument = {
    #           completion = {
    #               completionItem = {
    #                   snippetSupport = true,
    #                   preselectSupport = true,
    #                   tagSupport = { valueSet = { 1 } },
    #                   deprecatedSupport = true,
    #                   insertReplaceSupport = true,
    #                   labelDetailsSupport = true,
    #                   commitCharactersSupport = true,
    #                   resolveSupport = {
    #                       properties = { "documentation", "detail", "additionalTextEdits" },
    #                   },
    #                   documentationFormat = { "markdown" },
    #               },
    #           },
    #           codeAction = {
    #               dynamicRegistration = false,
    #               codeActionLiteralSupport = {
    #                   codeActionKind = {
    #                       valueSet = {
    #                           "",
    #                           "quickfix",
    #                           "refactor",
    #                           "refactor.extract",
    #                           "refactor.inline",
    #                           "refactor.rewrite",
    #                           "source",
    #                           "source.organizeImports",
    #                       },
    #                   },
    #               },
    #           },
    #       }
    #
    #       vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    #           virtual_text = false,
    #       })
    #
    #       -- LSPs
    #       local servers = {
    #           "bashls",
    #           -- "clangd",
    #           "ccls",
    #           "cmake",
    #           "cssls",
    #           "gopls",
    #           "hls",
    #           "html",
    #           "pyright",
    #           "sumneko_lua",
    #           "tsserver",
    #           "yamlls",
    #           "csharp_ls",
    #           "fsautocomplete",
    #           "svelte",
    #           "ansiblels",
    #           "jsonls",
    #           "marksman",
    #           "tailwindcss",
    #           "rnix",
    #       }
    #
    #       for _, lsp in ipairs(servers) do
    #           nvim_lsp[lsp].setup {
    #               capabilities = capabilities;
    #               on_attach = on_attach;
    #               init_options = {
    #                   onlyAnalyzeProjectsWithOpenFiles = true,
    #                   suggestFromUnimportedLibraries = false,
    #                   closingLabels = true,
    #               };
    #           }
    #       end
    #
    #       ----------
    #       -- LUASNIP
    #       ----------
    #       local ls = require("luasnip")
    #
    #       ls.snippets = {
    #           all = {
    #           },
    #
    #           cpp = {
    #               ls.parser.parse_snippet(
    #                   "fd",
    #                   "/**\n * @brief $0\n *\n */\nauto $1($2) -> $3;\n"
    #               ),
    #               ls.parser.parse_snippet(
    #                   "fi",
    #                   "auto $1($2) -> $3\n{\n    $0\n}\n"
    #               ),
    #               ls.parser.parse_snippet(
    #                   "fs",
    #                   "/**\n * @brief $4\n *\n */\nstatic auto $1($2) -> $3\n{\n    $0\n}\n"
    #               ),
    #           },
    #   
    #           typescriptreact = {
    #               ls.parser.parse_snippet(
    #                   "fc",
    #                   "interface $1Props {}\n\nconst $1: React.FC<$1Props> = (props) {\n  return <></>;\n}\n\nexport default $1"
    #               )
    #           }
    #       }
    #
    #       --------------
    #       -- COLORSCHEME
    #       --------------
    #       local utils = require("utils")
    #
    #       utils.opt("o", "termguicolors", true)
    #       vim.o.background = "dark"
    #
    #       -- vim.g.gruvbox_material_background = "medium"
    #       -- vim.g.gruvbox_material_palette = "original"
    #       -- vim.g.gruvbox_material_enable_italic = 1
    #       -- vim.g.gruvbox_material_enable_bold = 1
    #       -- vim.g.gruvbox_material_transparent_background = 1
    #       -- vim.g.gruvbox_material_sign_column_background = "none"
    #       -- vim.cmd([[colorscheme gruvbox-material]])
    #
    #       vim.g.tokyonight_style = "night"
    #       vim.g.tokyonight_transparent = true
    #       vim.cmd([[colorscheme tokyonight]])
    #     '';
    #
    #     viml = ''
    #       let bufferline = get(g:, "bufferline", {})
    #       let bufferline.animation = v:false
    #       let g:neoformat_try_node_exe = 1
    #     '';
    #   };
  };
}
