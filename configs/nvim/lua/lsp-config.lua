local lsp = require('lsp-zero')
lsp.preset('recommended')

require('mason').setup()
require('mason-null-ls').setup({
  -- ensure_installed = {
  --   'cpplint',
  --   'clang_format',
  --   'hadolint', --docker linter
  --   'staticcheck', -- go linter
  --   'eslint_d',
  --   'prettierd',
  --   'stylua', -- lua formatter
  --   'markdownlint', -- md linter
  --   'cbfmt', -- codeblock formatter
  --   'black', -- python formatter
  --   'flake8', -- python linter
  --   'shellcheck',
  --   'shellharden',
  --   'shfmt',
  --   'yamlfmt',
  --   'yamllint',
  --   'cspell'
  -- }
  automatic_setup = true,
})
require('mason-tool-installer').setup({
  ensure_installed = {
    'ansible-language-server',
    'astro-language-server',
    'bash-language-server',
    'cbfmt',
    'cpplint',
    'cspell',
    'eslint_d',
    'black', -- python formatter
    'flake8', -- python linter
    'gopls',
    'revive', -- go linter
    'staticcheck',
    'dockerfile-language-server',
    'hadolint', -- docker lint
    'haskell-language-server',
    'lua-language-server',
    'stylua',
    'markdownlint',
    'prettierd',
    'rnix-lsp',
    'rust-analyzer',
    'rustfmt',
    'shellcheck',
    'shellharden',
    'shfmt',
    'typescript-language-server',
    'yamlfmt',
    'yamllint',
  }
})

-- servers that need special care
lsp.nvim_workspace() -- nvim lua stuff
local rust_lsp = lsp.build_options('rust_analyzer', {})
lsp.ensure_installen({
  'sumneko_lua',
})

-- cmp config
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
lsp.setup_nvim_cmp({
  mapping = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  })
})

lsp.setup()

require('rust-tools').setup({
  server = rust_lsp,
  tools = {
    inlay_hints = {
      only_current_line = true
    }
  }
})

-- require('neodev').setup({
--   override = function(root_dir, library)
--     if require('neodev.util').has_file(root_dir, '/etc/nixos') then
--       library.enabled = true
--       library.plugins = true
--     end
--   end,
-- })
--
-- local function on_attach(client, bufnr)
--   local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
--   vim.api.nvim_exec_autocmds("User", {pattern = "LspAttached"})
--   if client.supports_method("textDocument/formatting") then
--     vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       group = augroup,
--       buffer = bufnr,
--       callback = function() return vim.lsp.buf.format({ bufnr = bufnr }) end
--     })
--   end
-- end
--
-- local lsp_defaults = {
--   flags = {
--     debounce_text_changes = 150
--   },
--   capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
--   on_attach = on_attach
-- }
--
-- local nvim_lsp = require("lspconfig")
-- nvim_lsp.util.default_config = vim.tbl_deep_extend("force", nvim_lsp.util.default_config, lsp_defaults)
--
-- do local _ = (require("luasnip.loaders.from_vscode")).lazy_load end
--
-- vim.opt.completeopt = {"menu", "menuone", "noselect"}
-- local cmp = require("cmp")
-- local luasnip = require("luasnip")
-- local select_opts = {behavior = cmp.SelectBehavior.Select}
--
-- cmp.setup({
--   snippet = {expand = function(x) return luasnip.lsp_expand(x.body) end},
--   sources = {
--     {name = "buffer"},
--     {name = "calc"},
--     {name = "conventionalcommits"},
--     {name = "luasnip"},
--     {name = "nvim_lsp"},
--     {name = "path"}
--   },
--   window = {
--     documentation = cmp.config.window.bordered()
--   },
--   formatting = {
--     fields = {"menu", "abbr", "kind"}
--   },
--   mapping = {
--     ["<c-p>"] = cmp.mapping.select_prev_item(select_opts),
--     ["<c-n>"] = cmp.mapping.select_next_item(select_opts),
--     ["<c-f>"] = cmp.mapping.scroll_docs(4),
--     ["<c-u>"] = cmp.mapping.scroll_docs(-4),
--     ["<c-e>"] = cmp.mapping.abort(),
--     ["<c-i>"] = cmp.mapping.confirm({select = true})
--   },
--   ["<c-d>"] = cmp.mapping(
--     function(fallback)
--       if luasnip.jumpable(1) then
--         return luasnip.jump(1)
--       else
--         return fallback()
--       end
--     end,
--     {"i", "s"}
--   ),
--   ["<c-b>"] = cmp.mapping(
--     function(fallback)
--       if luasnip.jumpable(-1) then
--         return luasnip.jump(-1)
--       else
--         return fallback()
--       end
--     end
--     , {"i", "s"}
--   )
-- })
--
-- cmp.setup.cmdline(":", {sources = {{name = "cmdline"}}})
-- cmp.setup.cmdline("/", {sources = {{name = "buffer"}}})
--
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics,
--   {
--     underline = true,
--     virtual_text = {
--       spacing = 5,
--       severity_limit = "Warning"
--     },
--     update_in_insert = true
--   }
-- )
--
-- require("typescript").setup({server = {on_attach = on_attach}})
--
-- local nls = require("null-ls")
-- local nc = nls.builtins.code_actions
-- local nd = nls.builtins.diagnostics
-- local nf = nls.builtins.formatting
-- nls.setup({
--   sources = {
--     nc.shellcheck,
--     nc.statix,
--     nd.ansiblelint,
--     nd.chktex,
--     nd.cppcheck,
--     nd.cspell.with({filetypes = {"markdown", "markdown.mdx"}}),
--     nd.hadolint,
--     nd.revive,
--     nd.shellcheck,
--     nd.statix,
--     nd.tsc.with({prefer_local = "node_modules/.bin"}),
--     nd.yamllint,
--     nf.black,
--     nf.cbfmt,
--     nf.clang_format,
--     nf.gofmt,
--     nf.latexindent,
--     nf.lua_format,
--     nf.nixpkgs_fmt,
--     nf.prettier.with({
--       filetypes = {
--         "html", "json", "jsonc", "yaml", "markdown", "markdown.mdx", "graphql", "handlebars", "css", "scss", "less"
--       },
--       prefer_local = "node_modules/.bin"
--     }),
--     nf.rome.with({
--       filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact"},
--       prefer_local = "node_modules/.bin"
--     }),
--     nf.rustfmt,
--     nf.shellharden,
--     nf.stylish_haskell,
--   },
--   on_attach = on_attach
-- })
--
-- local servers = {
--   "ansiblels",
--   "bashls",
--   "ccls",
--   "clojure_lsp",
--   "cssls",
--   "gopls",
--   "hls",
--   "html",
--   "julials",
--   "pyright",
--   "rnix",
--   "sumneko_lua",
--   "yamlls",
--   "zls"
-- }
--
-- for _, lsp in ipairs(servers) do
--   nvim_lsp[lsp].setup({
--     capabilities = lsp_defaults.capabilities,
--     on_attach = on_attach,
--     init_options = {
--       onlyAnalyzeProjectsWithOpenFiles = true,
--       closingLabels = true,
--       suggestFromUnimportedLibraries = false
--     }
--   })
-- end
