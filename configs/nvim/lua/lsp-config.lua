require("mason-update-all").setup({})

local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"eslint",
	"sumneko_lua",
})

lsp.nvim_workspace()
local rust_lsp = lsp.build_options("rust_analyzer", {})

-- servers that are installed globally and only need to be setup
lsp.setup_servers({ "julials", "ccls", force = true })

local null_opts = lsp.build_options("null-ls", {
	on_attach = function(client, bufnr)
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
	end,
})

local null_ls = require("null-ls")
local nc = null_ls.builtins.code_actions
local nd = null_ls.builtins.diagnostics
local nf = null_ls.builtins.formatting
null_ls.setup({
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
	on_attach = null_opts.on_attach,
})

local cmp = require("cmp")
local cmp_mappings = lsp.defaults.cmp_mappings()
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil
cmp_mappings['<CR>'] = nil
local cmp_sources = lsp.defaults.cmp_sources()
table.insert(cmp_sources, { name = "lua-latex-symbols", option = { cache = true } })

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  sources = cmp_sources
})
lsp.setup()

require("rust-tools").setup({
  server = rust_lsp,
  tools = { inlay_hints = { only_current_line = true } },
})

-- `/` cmdline setup.
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- `:` cmdline setup.
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	}),
})
