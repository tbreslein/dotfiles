(fn on_attach [client bufnr]
  (vim.api.nvim_buf_set_option bufnr :omnifunc "v:lua.vim.lsp.omnifunc")
  (when (client.supports_method :textDocument/formatting)
    (let [augroup (vim.api.nvim_create_augroup :LspFormatting {})]
      (vim.api.nvim_clear_autocmds {:group augroup :buffer bufnr})
      (vim.api.nvim_create_autocmd :BufWritePre
                                   {:group augroup
                                    :buffer bufnr
                                    :callback #(vim.lsp.buf.format {: bufnr})})))
  (let [bufopts {:noremap true :silent true :buffer bufnr}
        reg (. (require :which-key) :register)]
    (reg {:l {:name :LSP
              :D {1 "<cmd>lua vim.lsp.buf.declaration<cr>"
                  2 "go to declaration"
                  :buffer bufnr}
              :d {1 "<cmd>lua vim.lsp.buf.definitions<cr>"
                  2 "go to definitions"
                  :buffer bufnr}
              :i {1 "<cmd>lua vim.lsp.buf.implementation<cr>"
                  2 "go to implementation"
                  :buffer bufnr}
              :r {1 "<cmd>lua vim.lsp.buf.references<cr>"
                  2 "go to references"
                  :buffer bufnr}
              :n {1 "<cmd>lua vim.lsp.buf.rename<cr>" 2 :rename :buffer bufnr}
              :T {1 "<cmd>lua vim.lsp.buf.type_definition<cr>"
                  2 "go to type definition"
                  :buffer bufnr}
              :c {1 "<cmd>lua vim.lsp.buf.code_action<cr>"
                  2 "code action"
                  :buffer bufnr}
              :F {1 "<cmd>lua vim.lsp.buf.formatting<cr>"
                  2 :formatting
                  :buffer bufnr}
              :f ["<cmd>lua vim.diagnostic.open_float<cr>" "open float"]
              :l ["<cmd>lua vim.diagnostic.setloclist<cr>" "set loc list"]
              :q ["<cmd>lua vim.diagnostic.goto_prev<cr>" "prev diagnostic"]
              :e ["<cmd>lua vim.diagnostic.goto_next<cr>" "next diagnostic"]
              :K {1 "<cmd>lua vim.lsp.buf.hover<cr>" 2 :hover :buffer bufnr}
              :w {:name :workspace
                  :a {1 "<cmd>lua vim.lsp.buf.add_workspace_folder<cr>"
                      2 "add workspace folder"
                      :buffer bufnr}
                  :r {1 "<cmd>lua vim.lsp.buf.remove_workspace_folder<cr>"
                      2 "remove workspace folder"
                      :buffer bufnr}
                  :l {1 #(print (vim.inspect (vim.lsp.buf.list.workspace_folders [])))
                      2 "list workspace folders"
                      :buffer bufnr}}
              :t {:name :Trouble
                  :t [:<cmd>TroubleToggle<cr> "toggle trouble"]
                  :w ["<cmd>TroubleToggle workspace_diagnostics<cr>"
                      "toggle trouble workspace_diagnostics"]
                  :d ["<cmd>TroubleToggle document_diagnostics<cr>"
                      "toggle trouble document_diagnostics"]
                  :l ["<cmd>TroubleToggle loclist<cr>"
                      "toggle trouble loclist"]
                  :q ["<cmd>TroubleToggle quickfix<cr>"
                      "toggle trouble quickfix"]
                  :r ["<cmd>TroubleToggle lsp_references<cr>"
                      "toggle trouble lsp_references"]}}})))

(let [nls (require :null-ls)
      setup nls.setup
      nlsc nls.builtins.code_actions
      nlsd nls.builtins.diagnostics
      nlsf nls.builtins.formatting]
  (setup {:sources [nlsc.eslint
                    nlsc.shellcheck
                    nlsc.statix
                    nlsd.ansiblelint
                    nlsd.chktex
                    nlsd.cppcheck
                    (nlsd.cspell.with {:filetypes [:markdown]})
                    nlsd.eslint
                    nlsd.revive
                    nlsd.selene
                    nlsd.shellcheck
                    nlsd.statix
                    (nlsd.tsc.with {:prefer_local :node_modules/.bin})
                    nlsd.yamllint
                    nlsf.black
                    nlsf.cbfmt
                    nlsf.clang_format
                    nlsf.cmake_format
                    nlsf.fnlfmt
                    nlsf.gofmt
                    nlsf.latexindent
                    nlsf.lua_format
                    nlsf.nixpkgs_fmt
                    (nlsf.nixpkgs_fmt.with {:extra_filetypes [:svelte]})
                    nlsf.rustfmt
                    nlsf.shellharden
                    nlsf.stylish_haskell
                    nlsf.zigfmt]}))

(local nvim_lsp (require :lspconfig))

(let [lspsetup (. nvim_lsp :jsonls :setup)
      schemas (. (require :schemastore) :json :schemas)]
  (lspsetup {:settings {:json {:schemas (schemas) :validate {:enable true}}}}))

((. (require :typescript) :setup) {})
((. (require :rust-tools) :setup) {})

(local servers [:ansiblels
                :bashls
                :clangd
                :ccls
                :csharp_ls
                :cmake
                :cssls
                :fsautocomplete
                :gopls
                :hls
                :html
                :julials
                :pyright
                :rnix
                :svelte
                :yamlls
                :zls])

(each [_ server (ipairs servers)]
  (let [lspsetup (. nvim_lsp server :setup)]
    (lspsetup {: on_attach
               :init_options {:onlyAnalyzeProjectsWithOpenFiles true
                              :suggestFromUnimportedLibraries false
                              :closingLabels true}})))
