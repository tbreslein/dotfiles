local on_attach = function(client, bufnr)
    require('lsp_signature').on_attach({}, bufnr)
end

-- needed for nvim-ts-autotag
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        underline = true,
        virtual_text = {
            spacing = 5,
            severity_limit = 'Warning',
        },
        update_in_insert = true,
    }
)

require('typescript').setup({
    server = {
        on_attach = on_attach
    }
})

local nls = require('null-ls')
nls.setup({
    sources = {
        nls.builtins.code_actions.eslint,
        nls.builtins.code_actions.shellcheck,
        nls.builtins.code_actions.statix,

        --nls.builtins.completion.luasnip,

        nls.builtins.diagnostics.ansiblelint,
        nls.builtins.diagnostics.chktex,
        nls.builtins.diagnostics.cppcheck,
        nls.builtins.diagnostics.cspell.with({filetypes = {'markdown'}}),
        nls.builtins.diagnostics.eslint,
        nls.builtins.diagnostics.luacheck,
        nls.builtins.diagnostics.revive,
        nls.builtins.diagnostics.selene,
        nls.builtins.diagnostics.shellcheck,
        nls.builtins.diagnostics.statix,
        nls.builtins.diagnostics.tsc.with({prefer_local = 'node_modules/.bin'}),
        nls.builtins.diagnostics.yamllint,
        nls.builtins.formatting.black,
        nls.builtins.formatting.cbfmt,
        nls.builtins.formatting.clang_format,
        nls.builtins.formatting.cmake_format,
        nls.builtins.formatting.fnlfmt,
        nls.builtins.formatting.gofmt,
        nls.builtins.formatting.latexindent,
        nls.builtins.formatting.lua_format,
        nls.builtins.formatting.nixpkgs_fmt,
        nls.builtins.formatting.prettier.with({extra_filetypes = {'svelte'}}),
        nls.builtins.formatting.rustfmt,
        nls.builtins.formatting.shellharden,
        nls.builtins.formatting.stylish_haskell,
        nls.builtins.formatting.zigfmt,
    },
    on_attach = on_attach
})

local nvim_lsp = require('lspconfig')
local servers = {
    "ansiblels", "bashls", "clangd", "ccls", "csharp_ls", "cmake", "cssls",
    "fsautocomplete", "gopls", "hls", "html", "julials", "pyright", "rnix",
    "svelte", "yamlls", "zls"
}

for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        -- capabilities = capabilities,
        on_attach = on_attach,
        init_options = {
            onlyAnalyzeProjectsWithOpenFiles = true,
            suggestFromUnimportedLibraries = false,
            closingLabels = true
        }
    }
end

