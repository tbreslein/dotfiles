local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
    vim.api.nvim_exec_autocmds('User', {pattern = 'LspAttached'})
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function() vim.lsp.buf.format({bufnr = bufnr}) end
        })
    end
    require('lsp_signature').on_attach({}, bufnr)
    require('which-key').register({
        l = {
            name = 'Lsp',
            D = {vim.lsp.buf.declaration, 'declaration'},
            d = {vim.lsp.buf.definitions, 'definitions'},
            i = {vim.lsp.buf.implementation, 'implementation'},
            r = {vim.lsp.buf.references, 'references'},
            n = {vim.lsp.buf.rename, 'rename'},
            T = {vim.lsp.buf.type_definition, 'type definition'},
            c = {vim.lsp.buf.code_action, 'code action'},
            F = {vim.lsp.buf.formatting, 'formatting'},
            K = {vim.lsp.buf.hover, 'hover'},
            f = {vim.diagnostic.open_float, 'float diagnostic'},
            l = {vim.diagnostic.setloclist, 'setloclist'},
            q = {vim.diagnostic.goto_prev, 'prev diag'},
            e = {vim.diagnostic.goto_next, 'next diag'},
            w = {
                name = "workspace",
                a = {vim.lsp.buf.add_workspace_folder, 'add workspace folder'},
                r = {
                    vim.lsp.buf.remove_workspace_folder,
                    'remove workspace folder'
                },
                l = {vim.lsp.buf.add_workspace_folder, 'add workspace folder'}
            },
            t = {
                name = "Trouble",
                t = {'<cmd>TroubleToggle<cr>', 'toggle trouble'},
                w = {
                    '<cmd>TroubleToggle workspace_diagnostics<cr>',
                    'toggle workspace diagnostics'
                },
                d = {
                    '<cmd>TroubleToggle document_diagnostics<cr>',
                    'toggle document diagnostics'
                },
                l = {'<cmd>TroubleToggle loclist<cr>', 'toggle loclist'},
                q = {'<cmd>TroubleToggle quickfix<cr>', 'toggle quickfix'},
                r = {
                    '<cmd>TroubleToggle lsp_references<cr>',
                    'toggle lsp references'
                }
            }
        }
    }, {
        mode = 'n',
        prefix = '<leader>',
        buffer = bufnr,
        silent = true,
        noremap = true,
        nowait = false
    })
end

local lsp_defaults = {
    flags = {debounce_text_changes = 150},
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol
                                                                   .make_client_capabilities()),
    on_attach = on_attach
}
local nvim_lsp = require('lspconfig')
nvim_lsp.util.default_config = vim.tbl_deep_extend('force', nvim_lsp.util
                                                       .default_config,
                                                   lsp_defaults)

-- cmp + luasnip
require('luasnip.loaders.from_vscode').lazy_load()
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
local cmp = require('cmp')
local luasnip = require('luasnip')
local select_opts = {behavior = cmp.SelectBehavior.Select}
cmp.setup({
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
    sources = {
        {name = 'buffer'}, {name = 'calc'}, {name = 'conventionalcommits'},
        {name = 'luasnip'}, {name = 'nvim_lsp'}, {name = 'path'}
    },
    window = {documentation = cmp.config.window.bordered()},
    formatting = {
        fields = {'menu', 'abbr', 'kind'}
        -- format = function(entry, item)
        --     local menu_icon = {
        --         nvim_lsp = 'λ',
        --         luasnip = '⋗',
        --         buffer = 'Ω',
        --         path = '🖫',
        --     }
        --     item.menu = menu_icon[entry.source.name]
        --     return item
        -- end,
    },
    mapping = {
        ['<c-p>'] = cmp.mapping.select_prev_item(select_opts),
        ['<c-n>'] = cmp.mapping.select_next_item(select_opts),
        ['<c-u>'] = cmp.mapping.scroll_docs(4),
        ['<c-f>'] = cmp.mapping.scroll_docs(-4),
        ['<c-e>'] = cmp.mapping.abort(),
        ['<c-i>'] = cmp.mapping.confirm({select = true}),
        ['<c-d>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<c-b>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'})
    }
})
cmp.setup.cmdline(':', {sources = {{name = 'cmdline'}}})
cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

-- needed for nvim-ts-autotag
vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = {spacing = 5, severity_limit = 'Warning'},
        update_in_insert = true
    })

require('typescript').setup({server = {on_attach = on_attach}})

local luadev = require('lua-dev').setup({
    lspconfig = {settings = {Lua = {diagnostics = {globals = {'vim'}}}}}
})
nvim_lsp.sumneko_lua.setup(luadev)

local nls = require('null-ls')
nls.setup({
    sources = {
        nls.builtins.code_actions.eslint, nls.builtins.code_actions.shellcheck,
        nls.builtins.code_actions.statix, nls.builtins.diagnostics.ansiblelint,
        nls.builtins.diagnostics.chktex, nls.builtins.diagnostics.clj_kondo,
        nls.builtins.diagnostics.cppcheck,
        nls.builtins.diagnostics.cspell.with({filetypes = {'markdown'}}),
        nls.builtins.diagnostics.eslint, nls.builtins.diagnostics.revive,
        nls.builtins.diagnostics.shellcheck, nls.builtins.diagnostics.statix,
        nls.builtins.diagnostics.tsc.with({prefer_local = 'node_modules/.bin'}),
        nls.builtins.diagnostics.yamllint, nls.builtins.formatting.black,
        nls.builtins.formatting.cbfmt, nls.builtins.formatting.clang_format,
        nls.builtins.formatting.cmake_format, nls.builtins.formatting.fnlfmt,
        nls.builtins.formatting.gofmt, nls.builtins.formatting.latexindent,
        nls.builtins.formatting.lua_format, nls.builtins.formatting.nixpkgs_fmt,
        nls.builtins.formatting.prettier.with({extra_filetypes = {'svelte'}}),
        nls.builtins.formatting.rustfmt, nls.builtins.formatting.shellharden,
        nls.builtins.formatting.stylish_haskell, nls.builtins.formatting.zigfmt,
        nls.builtins.formatting.zprint
    },
    on_attach = on_attach
})

local servers = {
    "ansiblels", "bashls", "clangd", "ccls", "clojure_lsp", "cmake", "cssls",
    "csharp_ls", "fsautocomplete", "gopls", "hls", "html", "julials", "pyright",
    "rnix", "svelte", "yamlls", "zls"
}

for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        capabilities = lsp_defaults.capabilities,
        on_attach = on_attach,
        init_options = {
            onlyAnalyzeProjectsWithOpenFiles = true,
            suggestFromUnimportedLibraries = false,
            closingLabels = true
        }
    }
end
