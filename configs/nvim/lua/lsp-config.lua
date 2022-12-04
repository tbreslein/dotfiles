local lsp = require('lsp-zero')
lsp.preset('recommended')

local servers = {
  'ansible-language-server',
  'astro-language-server',
  'bash-language-server',
  'cbfmt',
  'clang-format',
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
  -- 'haskell-language-server',
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

require('mason').setup()
require('mason-null-ls').setup({ automatic_setup = true })
require('mason-tool-installer').setup({ ensure_installed = servers })

-- servers that need special care
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

lsp.setup_servers(servers)
lsp.setup()

require('rust-tools').setup({
  server = rust_lsp,
  tools = {
    inlay_hints = {
      only_current_line = true
    }
  }
})
