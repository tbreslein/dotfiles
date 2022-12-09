local lsp = require('lsp-zero')
lsp.set_preferences({
  suggest_lsp_servers = false,
  setup_servers_on_start = true,
  set_lsp_keymaps = true,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = true,
  call_servers = 'local',
  sign_icons = {
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = ''
  }
})

local null_ls = require('null-ls')
local null_opts = lsp.build_options('null-ls', {
  on_attach = function(client, bufnr)
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    vim.api.nvim_exec_autocmds("User", {pattern = "LspAttached"})
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function() return vim.lsp.buf.format({ bufnr = bufnr }) end
      })
    end
  end
})

lsp.setup_servers({
  -- nix
  "rnix",
  -- js/ts/html
  "html",
  "cssls",
  "tsserver",
  "eslint",
  -- c/c++
  "ccls",
  -- haskell
  "hls",
  -- shell, docker, config files, etc
  "dockerls",
  "shellcheck",
  "ansiblels",
  "bashls",
  "yamlls",
  -- mardown + tex
  "cbfmt",
  "cspell",
  "ltex-ls",
  -- go
  "gopls",
  "gofumpt",
  "revive",
  "staticcheck",
  -- python
  "black",
  "flake8",
  -- rust
  "rust-analyzer",
  "rustfmt",
})
lsp.nvim_workspace() -- nvim lua stuff
local rust_lsp = lsp.build_options('rust_analyzer', {})

-- cmp config
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
lsp.setup_nvim_cmp({
  mapping = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  })
})

local nc = null_ls.builtins.code_actions
local nd = null_ls.builtins.diagnostics
local nf = null_ls.builtins.formatting
null_ls.setup({
  on_attach = null_opts.on_attach,
  sources = {
    -- nix
    nc.statix,
    nd.statix,
    nf.nixpkgs_fmt,
    -- c/c++
    -- nd.cppcheck,
    nf.clang_format,
    -- js/ts
    nd.eslint,
    nf.prettier,
    nd.tsc.with({prefer_local = "node_modules/.bin"}),
    -- nf.rome.with({
    --   filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact"},
    --   prefer_local = "node_modules/.bin"
    -- }),
    -- lua
    nf.stylua,
    nd.luacheck,
    -- haskell
    nf.stylish_haskell,
    -- shell, docker, config files, etc
    nd.shellcheck,
    nd.ansiblelint,
    nd.hadolint,
    -- markdown
    nd.cspell.with({filetypes = {"markdown", "markdown.mdx"}}),
    nf.cbfmt,
    -- go
    nf.gofumpt,
    nd.revive,
    nd.staticcheck,
    -- python
    nf.black,
    -- tex
    nd.chktex,
    nf.latexindent,
    -- rust
    nf.rustfmt,
  }
})

require('mason-null-ls').setup({
  ensure_installed = nil,
  automatic_installation = true,
  automatic_setup = true,
})
require('mason-null-ls').setup_handlers()

lsp.setup()

require('rust-tools').setup({
  server = rust_lsp,
  tools = {
    inlay_hints = {
      only_current_line = true
    }
  }
})

-- local servers = {
--   'ansible-language-server',
--   'astro-language-server',
--   'bash-language-server',
--   'cbfmt',
--   'clang-format',
--   'cpplint',
--   'cspell',
--   'eslint_d',
--   'black', -- python formatter
--   'flake8', -- python linter
--   'gopls',
--   'revive', -- go linter
--   'staticcheck',
--   'dockerfile-language-server',
--   'hadolint', -- docker lint
--   -- 'haskell-language-server',
--   'lua-language-server',
--   -- 'stylua',
--   'markdownlint',
--   'prettierd',
--   'rnix-lsp',
--   'rust-analyzer',
--   'rustfmt',
--   'shellcheck',
--   'shellharden',
--   'shfmt',
--   'typescript-language-server',
--   'yamlfmt',
--   'yamllint',
-- }
--
-- require('mason').setup()
-- require('mason-tool-installer').setup({ ensure_installed = servers })
--
-- -- servers that need special care
-- lsp.nvim_workspace() -- nvim lua stuff
-- local rust_lsp = lsp.build_options('rust_analyzer', {})
--
-- -- cmp config
-- local cmp = require('cmp')
-- local cmp_select = {behavior = cmp.SelectBehavior.Select}
-- lsp.setup_nvim_cmp({
--   mapping = lsp.defaults.cmp_mappings({
--     ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--     ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--   })
-- })
--
-- lsp.setup_servers(servers)
-- lsp.setup()
--
-- require('rust-tools').setup({
--   server = rust_lsp,
--   tools = {
--     inlay_hints = {
--       only_current_line = true
--     }
--   }
-- })
--
-- -- Null-LS
-- local nls = require("null-ls")
-- local nls_opts = lsp.build_options('null-ls', {})
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
--     nf.stylua,
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
--   on_attach = function(client, bufnr)
--     if client.supports_method("textDocument/formatting") then
--       vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--       vim.api.nvim_create_autocmd("BufWritePre", {
--         group = augroup,
--         buffer = bufnr,
--         callback = function()
--           -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
--           vim.lsp.buf.format({bufnr = bufnr})
--         end,
--       })
--     end
--   end,
-- })
--
-- require('mason-null-ls').setup({
--   ensure_installed = nil,
--   automatic_installation = true,
--   automatic_setup = true,
-- })
-- require('mason-null-ls').setup_handlers()
