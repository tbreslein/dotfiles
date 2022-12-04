local function on_attach(client, bufnr)
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  vim.api.nvim_exec_autocmds("User", {pattern = "LspAttached"})
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function() return vim.lsp.buf.format({ bufnr = bufnr }) end
    })
  else
  end
  require("which-key").register({
    l = {
      name = "Lsp",
      D = {vim.lsp.buf.declaration, "declaration"},
      d = {vim.lsp.buf.definitions, "definitions"},
      i = {vim.lsp.buf.implementation, "implementation"},
      r = {vim.lsp.buf.references, "references"},
      n = {vim.lsp.buf.rename, "rename"},
      T = {vim.lsp.buf.type_definition, "type definition"},
      c = {vim.lsp.buf.code_action, "code action"},
      F = {vim.lsp.buf.formatting, "formatting"},
      K = {vim.lsp.buf.hover, "hover"},
      f = {vim.diagnostic.open_float, "float diagnostic"},
      l = {vim.diagnostic.setloclist, "setloclist"},
      q = {vim.diagnostic.goto_prev, "prev diag"},
      e = {vim.diagnostic.goto_next, "next diag"},
      w = {
        name = "workspace",
        a = {vim.lsp.buf.add_workspace_folder, "add workspace folder"},
        r = {vim.lsp.buf.remove_workspace_folder, "remove workspace folder"},
        l = {vim.lsp.buf.list_workspace_folders, "list workspace folders"}
      },
      t = {
        name = "Trouble",
        t = {"<cmd>TroubleToggle<cr>", "toggle trouble"},
        w = {"<cmd>TroubleToggle workspace_diagnostics<cr>", "toggle workspace diagnostics"},
        d = {"<cmd>TroubleToggle document_diagnostics<cr>", "toggle document diagnostics"},
        l = {"<cmd>TroubleToggle loclist<cr>", "toggle loclist"},
        q = {"<cmd>TroubleToggle quickfix<cr>", "toggle quickfix"},
        r = {"<cmd>TroubleToggle lsp_references<cr>", "toggle lsp references"}
      }
    }
  })
end

local lsp_defaults = {
  flags = {
    debounce_text_changes = 150
  },
  capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = on_attach
}

local nvim_lsp = require("lspconfig")
nvim_lsp.util.default_config = vim.tbl_deep_extend("force", nvim_lsp.util.default_config, lsp_defaults)

do local _ = (require("luasnip.loaders.from_vscode")).lazy_load end

vim.opt.completeopt = {"menu", "menuone", "noselect"}
local cmp = require("cmp")
local luasnip = require("luasnip")
local select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  snippet = {expand = function(x) return luasnip.lsp_expand(x.body) end},
  sources = {
    {name = "buffer"},
    {name = "calc"},
    {name = "conventionalcommits"},
    {name = "luasnip"},
    {name = "nvim_lsp"},
    {name = "path"}
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  formatting = {
    fields = {"menu", "abbr", "kind"}
  },
  mapping = {
    ["<c-p>"] = cmp.mapping.select_prev_item(select_opts),
    ["<c-n>"] = cmp.mapping.select_next_item(select_opts),
    ["<c-f>"] = cmp.mapping.scroll_docs(4),
    ["<c-u>"] = cmp.mapping.scroll_docs(-4),
    ["<c-e>"] = cmp.mapping.abort(),
    ["<c-i>"] = cmp.mapping.confirm({select = true})
  },
  ["<c-d>"] = cmp.mapping(
    function(fallback)
      if luasnip.jumpable(1) then
        return luasnip.jump(1)
      else
        return fallback()
      end
    end,
    {"i", "s"}
  ),
  ["<c-b>"] = cmp.mapping(
    function(fallback)
      if luasnip.jumpable(-1) then
        return luasnip.jump(-1)
      else
        return fallback()
      end
    end
    , {"i", "s"}
  )
})

cmp.setup.cmdline(":", {sources = {{name = "cmdline"}}})
cmp.setup.cmdline("/", {sources = {{name = "buffer"}}})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    virtual_text = {
      spacing = 5,
      severity_limit = "Warning"
    },
    update_in_insert = true
  }
)

require("typescript").setup({server = {on_attach = on_attach}})

local nls = require("null-ls")
local nc = nls.builtins.code_actions
local nd = nls.builtins.diagnostics
local nf = nls.builtins.formatting
nls.setup({
  sources = {
    nc.shellcheck,
    nc.statix,
    nd.ansiblelint,
    nd.chktex,
    nd.clj_kondo,
    nd.cppcheck,
    nd.cspell.with({filetypes = {"markdown", "markdown.mdx"}}),
    nd.hadolint,
    nd.revive,
    nd.shellcheck,
    nd.statix,
    nd.tsc.with({prefer_local = "node_modules/.bin"}),
    nd.yamllint,
    nf.black,
    nf.cbfmt,
    nf.clang_format,
    nf.fnlfmt,
    nf.gofmt,
    nf.latexindent,
    nf.lua_format,
    nf.nixpkgs_fmt,
    nf.prettier.with({
      filetypes = {
        "html", "json", "jsonc", "yaml", "markdown", "markdown.mdx", "graphql", "handlebars", "css", "scss", "less"
      },
      prefer_local = "node_modules/.bin"
    }),
    nf.rome.with({
      filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact"},
      prefer_local = "node_modules/.bin"
    }),
    nf.rustfmt,
    nf.shellharden,
    nf.stylish_haskell,
    nf.zigfmt,
    nf.zprint
  },
  on_attach = on_attach
})

local servers = {
  "ansiblels",
  "bashls",
  "ccls",
  "clojure_lsp",
  "cssls",
  "gopls",
  "hls",
  "html",
  "julials",
  "pyright",
  "rnix",
  "yamlls",
  "zls"
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    capabilities = lsp_defaults.capabilities,
    on_attach = on_attach,
    init_options = {
      onlyAnalyzeProjectsWithOpenFiles = true,
      closingLabels = true,
      suggestFromUnimportedLibraries = false
    }
  })
end
