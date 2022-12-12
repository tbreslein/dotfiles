require("neodev").setup({})

local function on_attach(client, bufnr)
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        return vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

local lsp_defaults = {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = on_attach,
}

local nvim_lsp = require("lspconfig")
nvim_lsp.util.default_config = vim.tbl_deep_extend("force", nvim_lsp.util.default_config, lsp_defaults)

do
  local _ = (require("luasnip.loaders.from_vscode")).lazy_load
end

vim.opt.completeopt = { "menu", "menuone", "noselect" }
local cmp = require("cmp")
local luasnip = require("luasnip")
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  snippet = {
    expand = function(x)
      return luasnip.lsp_expand(x.body)
    end,
  },
  sources = {
    { name = "buffer" },
    { name = "calc" },
    { name = "conventionalcommits" },
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "path" },
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = { "menu", "abbr", "kind" },
  },
  mapping = {
    ["<c-p>"] = cmp.mapping.select_prev_item(select_opts),
    ["<c-n>"] = cmp.mapping.select_next_item(select_opts),
    ["<c-f>"] = cmp.mapping.scroll_docs(4),
    ["<c-b>"] = cmp.mapping.scroll_docs(-4),
    ["<c-e>"] = cmp.mapping.abort(),
    ["<cr>"] = cmp.mapping.confirm({ select = true }),
  },
  ["<c-d>"] = cmp.mapping(function(fallback)
    if luasnip.jumpable(1) then
      return luasnip.jump(1)
    else
      return fallback()
    end
  end, { "i", "s" }),
  ["<c-b>"] = cmp.mapping(function(fallback)
    if luasnip.jumpable(-1) then
      return luasnip.jump(-1)
    else
      return fallback()
    end
  end, { "i", "s" }),
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { { name = "buffer" } },
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = {
    spacing = 5,
    severity_limit = "Warning",
  },
  update_in_insert = true,
})

require("typescript").setup({ server = { on_attach = on_attach } })

local nls = require("null-ls")
local nc = nls.builtins.code_actions
local nd = nls.builtins.diagnostics
local nf = nls.builtins.formatting
nls.setup({
  sources = {
    -- nix
    nc.statix,
    nd.statix,
    nf.nixpkgs_fmt,
    -- c/c++
    nd.cppcheck,
    nf.clang_format,
    -- js/ts
    nd.eslint,
    nf.prettier,
    nd.tsc.with({ prefer_local = "node_modules/.bin" }),
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
    nd.cspell.with({ filetypes = { "markdown", "markdown.mdx" } }),
    nf.cbfmt,
    -- go
    nf.gofumpt,
    nd.revive,
    nd.staticcheck,
    -- python
    nf.black,
    -- rust
    nf.rustfmt,
  },
  on_attach = on_attach,
})

local servers = {
  "ansiblels",
  "bashls",
  "ccls",
  "cssls",
  "gopls",
  "hls",
  "html",
  "pyright",
  "rnix",
  "sumneko_lua",
  "yamlls",
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    capabilities = lsp_defaults.capabilities,
    on_attach = on_attach,
    init_options = {
      onlyAnalyzeProjectsWithOpenFiles = true,
      closingLabels = true,
      suggestFromUnimportedLibraries = false,
    },
  })
end
