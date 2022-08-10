local on_attach = function(client, bufnr)
    local opts = { noremap=true, silent=true }
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Set some keybinds conditional on server capabilities
    -- if client.resolved_capabilities.document_formatting then
    --     buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    -- elseif client.resolved_capabilities.document_range_formatting then
    --     buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    -- end
    if client.server_capabilities.document_formatting then
        buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.server_capabilities.document_range_formatting then
        buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
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
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
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
        [types.choiceNode] = {
            active = {
                virt_text = { { "←", "Error" } }
            }
        }
    }
}

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
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

        ["<C-k>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { "i", "s" }),
        ["<C-j>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { "i", "s" }),
        ["<C-l>"] = cmp.mapping(function(fallback)
            if luasnip.choice_active() then
                luasnip.change_choice(1)
            end
        end),

        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c'}),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ['<C-i>'] = cmp.mapping.confirm({ select = true }),
        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_next_item())
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = 'buffer' },
    }),
})

cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

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
            tagSupport = { valueSet = { 1 } },
            deprecatedSupport = true,
            insertReplaceSupport = true,
            labelDetailsSupport = true,
            commitCharactersSupport = true,
            resolveSupport = {
                properties = { "documentation", "detail", "additionalTextEdits" },
            },
            documentationFormat = { "markdown" },
        },
    },
    codeAction = {
        dynamicRegistration = false,
        codeActionLiteralSupport = {
            codeActionKind = {
                valueSet = {
                    "",
                    "quickfix",
                    "refactor",
                    "refactor.extract",
                    "refactor.inline",
                    "refactor.rewrite",
                    "source",
                    "source.organizeImports",
                },
            },
        },
    },
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
})

-- LSPs
local servers = {
    "bashls",
    "clangd",
    "ccls",
    "cmake",
    "cssls",
    "gopls",
    "hls",
    "html",
    "pyright",
    "sumneko_lua",
    "tsserver",
    "eslint",
    "yamlls",
    "csharp_ls",
    "fsautocomplete",
    "svelte",
    "ansiblels",
    "jsonls",
    "tailwindcss",
    "rnix",
    "julials",
}

nvim_lsp["eslint"].setup {
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte" };
    capabilities = capabilities;
    on_attach = on_attach;
    init_options = {
        onlyAnalyzeProjectsWithOpenFiles = true,
        suggestFromUnimportedLibraries = false,
        closingLabels = true,
    };
}

for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        capabilities = capabilities;
        on_attach = on_attach;
        init_options = {
            onlyAnalyzeProjectsWithOpenFiles = true,
            suggestFromUnimportedLibraries = false,
            closingLabels = true,
        };
    }
end

