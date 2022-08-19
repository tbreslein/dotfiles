local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    bufnr = bufnr,
                    filter = function(this_client)
                        return this_client.name == "null-ls"
                    end
                })
            end
        })
    end

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.document_highlight then
        vim.api.nvim_exec([[
            hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
            hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
            hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
            augroup lsp_document_highlight
            autocmd! * <buffer>
            augroup END
        ]], false)
    end
end

local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                     .protocol
                                                                     .make_client_capabilities())
local cmp = require('cmp')
local luasnip = require('luasnip')
local types = require('luasnip.util.types')

luasnip.config.set_config {
    -- this tells luasnip to remember to keep around the last snippet.
    -- you can jump back into it even if you move outside of the selection.
    history = true,

    -- enables updating snippets as you type, for dynamic snippets
    updateevents = "TextChanged,TextChangedI",

    -- Autosnippets
    enable_autosnippets = true,

    ext_opts = {
        [types.choiceNode] = {active = {virt_text = {{"←", "Error"}}}}
    }
}

cmp.setup({
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
    mapping = {
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item()),
        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item()),
        -- ["<C-n>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_next_item()
        --     elseif luasnip.expand_or_jumpable() then
        --         luasnip.expand_or_jump()
        --     elseif has_words_before() then
        --         cmp.complete()
        --     else
        --         fallback()
        --     end
        -- end, { "i", "s" }),
        --
        -- ["<C-p>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_prev_item()
        --     elseif luasnip.jumpable(-1) then
        --         luasnip.jump(-1)
        --     else
        --         fallback()
        --     end
        -- end, { "i", "s" }),

        ["<C-k>"] = cmp.mapping(function(_)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            end
        end, {"i", "s"}),
        ["<C-j>"] = cmp.mapping(function(_)
            if luasnip.jumpable(-1) then luasnip.jump(-1) end
        end, {"i", "s"}),
        ["<C-l>"] = cmp.mapping(function(_)
            if luasnip.choice_active() then luasnip.change_choice(1) end
        end),

        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ['<C-i>'] = cmp.mapping.confirm({select = true})
        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_next_item())
    },
    sources = cmp.config.sources({
        {name = "nvim_lsp"}, {name = "luasnip"}, {name = "git"}
    }, {{name = 'buffer'}})
})

cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

cmp.setup.cmdline(':', {
    sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})

require('cmp_git').setup()

-- Code actions
-- capabilities.textDocument.codeAction = {
--     dynamicRegistration = false;
--     codeActionLiteralSupport = {
--         codeActionKind = {
--             valueSet = {
--                 "",
--                 "quickfix",
--                 "refactor",
--                 "refactor.extract",
--                 "refactor.inline",
--                 "refactor.rewrite",
--                 "source",
--                 "source.organizeImports",
--             };
--         };
--     };
-- }

-- Snippets
-- capabilities.textDocument.completion.completionItem.snippetSupport = true;

capabilities.textDocument = {
    completion = {
        completionItem = {
            snippetSupport = true,
            preselectSupport = true,
            tagSupport = {valueSet = {1}},
            deprecatedSupport = true,
            insertReplaceSupport = true,
            labelDetailsSupport = true,
            commitCharactersSupport = true,
            resolveSupport = {
                properties = {"documentation", "detail", "additionalTextEdits"}
            },
            documentationFormat = {"markdown"}
        }
    },
    codeAction = {
        dynamicRegistration = false,
        codeActionLiteralSupport = {
            codeActionKind = {
                valueSet = {
                    "", "quickfix", "refactor", "refactor.extract",
                    "refactor.inline", "refactor.rewrite", "source",
                    "source.organizeImports"
                }
            }
        }
    }
}

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {virtual_text = false})

-- LSPs
local servers = {
    "ansiblels", "bashls", "clangd", "ccls", "csharp_ls", "cmake", "cssls",
    "fsautocomplete", "gopls", "hls", "html", "julials", "pyright", "rnix",
    "sumneko_lua", "svelte", "yamlls", "zls"
}

for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        init_options = {
            onlyAnalyzeProjectsWithOpenFiles = true,
            suggestFromUnimportedLibraries = false,
            closingLabels = true
        }
    }
end

require('lspconfig').jsonls.setup {
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = {enable = true}
        }
    }
}

require('typescript').setup {}
require('rust-tools').setup {}

require('null-ls').setup {
    sources = {
        require('null-ls').builtins.code_actions.eslint,
        require('null-ls').builtins.code_actions.shellcheck,
        require('null-ls').builtins.code_actions.statix,

        require('null-ls').builtins.diagnostics.ansiblelint,
        require('null-ls').builtins.diagnostics.chktex,
        require('null-ls').builtins.diagnostics.cppcheck,
        require('null-ls').builtins.diagnostics.cspell
            .with({filetypes = {"markdown"}}),
        require('null-ls').builtins.diagnostics.eslint,
        require('null-ls').builtins.diagnostics.revive, -- go linter
        require('null-ls').builtins.diagnostics.selene,
        require('null-ls').builtins.diagnostics.shellcheck,
        require('null-ls').builtins.diagnostics.statix,
        require('null-ls').builtins.diagnostics.tsc,
        require('null-ls').builtins.diagnostics.yamllint,

        require('null-ls').builtins.formatting.black,
        require('null-ls').builtins.formatting.cbfmt,
        require('null-ls').builtins.formatting.clang_format,
        require('null-ls').builtins.formatting.cmake_format,
        require('null-ls').builtins.formatting.gofmt,
        require('null-ls').builtins.formatting.latexindent,
        require('null-ls').builtins.formatting.lua_format,
        require('null-ls').builtins.formatting.nixpkgs_fmt,
        require('null-ls').builtins.formatting.prettier
            .with({filetypes = {"svelte"}}),
        require('null-ls').builtins.formatting.rustfmt,
        require('null-ls').builtins.formatting.shellharden,
        require('null-ls').builtins.formatting.stylish_haskell,
        require('null-ls').builtins.formatting.zigfmt
    },
    on_attach = on_attach
}
