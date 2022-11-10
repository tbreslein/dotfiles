(import-macros {: plugin-setup} :util-macros)

(local on_attach (fn [client bufnr]
                   (let [augroup (vim.api.nvim_create_augroup :LspFormatting {})]
                     (vim.api.nvim_exec_autocmds :User {:pattern :LspAttached})
                     (when (client.supports_method :textDocument/formatting)
                       (vim.api.nvim_clear_autocmds {:group augroup
                                                     :buffer bufnr})
                       (vim.api.nvim_create_autocmd :BufWritePre
                                                    {:group augroup
                                                     :buffer bufnr
                                                     :callback #(vim.lsp.buf.format {: bufnr})}))
                     ((. (require :lsp_signature) :on_attach) {} bufnr)
                     (let [reg (. (require :which-key) :register)]
                       (reg {:l {:name :Lsp
                                 :D [vim.lsp.buf.declaration :declaration]
                                 :d [vim.lsp.buf.definitions :definitions]
                                 :i [vim.lsp.buf.implementation
                                     :implementation]
                                 :r [vim.lsp.buf.references :references]
                                 :n [vim.lsp.buf.rename :rename]
                                 :T [vim.lsp.buf.type_definition
                                     "type definition"]
                                 :c [vim.lsp.buf.code_action "code action"]
                                 :F [vim.lsp.buf.formatting :formatting]
                                 :K [vim.lsp.buf.hover :hover]
                                 :f [vim.diagnostic.open_float
                                     "float diagnostic"]
                                 :l [vim.diagnostic.setloclist :setloclist]
                                 :q [vim.diagnostic.goto_prev "prev diag"]
                                 :e [vim.diagnostic.goto_next "next diag"]
                                 :w {:name :workspace
                                     :a [vim.lsp.buf.add_workspace_folder
                                         "add workspace folder"]
                                     :r [vim.lsp.buf.remove_workspace_folder
                                         "remove workspace folder"]
                                     :l [vim.lsp.buf.list_workspace_folders
                                         "list workspace folders"]}
                                 :t {:name :Trouble
                                     :t [:<cmd>TroubleToggle<cr>
                                         "toggle trouble"]
                                     :w ["<cmd>TroubleToggle workspace_diagnostics<cr>"
                                         "toggle workspace diagnostics"]
                                     :d ["<cmd>TroubleToggle document_diagnostics<cr>"
                                         "toggle document diagnostics"]
                                     :l ["<cmd>TroubleToggle loclist<cr>"
                                         "toggle loclist"]
                                     :q ["<cmd>TroubleToggle quickfix<cr>"
                                         "toggle quickfix"]
                                     :r ["<cmd>TroubleToggle lsp_references<cr>"
                                         "toggle lsp references"]}}}
                            {:mode :n
                             :prefix :<leader>
                             :buffer bufnr
                             :silent true
                             :noremap true
                             :nowait false}))
                     nil)))

(local lsp-defaults {:flags {:debounce_text_changes 150}
                     :capabilities ((. (require :cmp_nvim_lsp)
                                       :default_capabilities) (vim.lsp.protocol.make_client_capabilities))
                     : on_attach})

(tset lsp-defaults :capabilities :offsetEncoding [:utf-16])

(local nvim_lsp (require :lspconfig))
(set nvim_lsp.util.default_config
     (vim.tbl_deep_extend :force nvim_lsp.util.default_config lsp-defaults))

;; -------------
;; cmp + luasnip
;; -------------

(. (require :luasnip.loaders.from_vscode) :lazy_load)
(set vim.opt.completeopt [:menu :menuone :noselect])
(local cmp (require :cmp))
(local luasnip (require :luasnip))
(local select_opts {:behavior cmp.SelectBehavior.Select})
(cmp.setup {:snippet {:expand #(luasnip.lsp_expand $1.body)}
            :sources [{:name :buffer}
                      {:name :calc}
                      {:name :conventionalcommits}
                      {:name :luasnip}
                      {:name :nvim_lsp}
                      {:name :path}]
            :window {:documentation (cmp.config.window.bordered)}
            :formatting {:fields [:menu :abbr :kind]}
            :mapping {:<c-p> (cmp.mapping.select_prev_item select_opts)
                      :<c-n> (cmp.mapping.select_next_item select_opts)
                      :<c-u> (cmp.mapping.scroll_docs 4)
                      :<c-f> (cmp.mapping.scroll_docs -4)
                      :<c-e> (cmp.mapping.abort)
                      :<c-i> (cmp.mapping.confirm {:select true})}
            :<c-d> (cmp.mapping (fn [fallback]
                                  (if (luasnip.jumpable 1) (luasnip.jump 1)
                                      (fallback)))
                                [:i :s])
            :<c-b> (cmp.mapping (fn [fallback]
                                  (if (luasnip.jumpable -1) (luasnip.jump -1)
                                      (fallback)))
                                [:i :s])})

(cmp.setup.cmdline ":" {:sources [{:name :cmdline}]})
(cmp.setup.cmdline "/" {:sources [{:name :buffer}]})

;; needed for nvim-ts-autotag

(tset vim.lsp.handlers :textDocument/publishDiagnostics
      (vim.lsp.with vim.lsp.diagnostic.on_publish_diagnostics
                    {:underline true
                     :virtual_text {:spacing 5 :severity_limit :Warning}
                     :update_in_insert true}))

;; Language Servers

(plugin-setup :typescript {:server {: on_attach}})

(let [nls (require :null-ls)
      nc nls.builtins.code_actions
      nd nls.builtins.diagnostics
      nf nls.builtins.formatting]
  (nls.setup {:sources [;;nc.eslint
                        nc.shellcheck
                        nc.statix
                        nd.ansiblelint
                        nd.chktex
                        nd.clj_kondo
                        nd.cppcheck
                        (nd.cspell.with {:filetypes [:markdown :markdown.mdx]})
                        ;;nd.eslint
                        nd.hadolint
                        nd.revive
                        nd.shellcheck
                        nd.statix
                        (nd.tsc.with {:prefer_local :node_modules/.bin})
                        nd.yamllint
                        nf.black
                        nf.cbfmt
                        nf.clang_format
                        nf.fnlfmt
                        nf.gofmt
                        nf.latexindent
                        nf.lua_format
                        nf.nixpkgs_fmt
                        (nf.prettier.with {:filetypes [:html
                                                       :json
                                                       :jsonc
                                                       :yaml
                                                       :markdown
                                                       :markdown.mdx
                                                       :graphql
                                                       :handlebars
                                                       :css
                                                       :scss
                                                       :less]
                                           :prefer_local :node_modules/.bin})
                        (nf.rome.with {:filetypes [:javascript
                                                   :javascriptreact
                                                   :typescript
                                                   :typescriptreact]
                                       :prefer_local :node_modules/.bin})
                        nf.rustfmt
                        nf.shellharden
                        nf.stylish_haskell
                        nf.zigfmt
                        nf.zprint]
              : on_attach}))

(let [servers [:ansiblels
               :bashls
               :clangd
               ;; :ccls
               :clojure_lsp
               :cssls
               :gopls
               :hls
               :html
               :julials
               :pyright
               ;; :rust_analyzer
               :rnix
               :yamlls
               :zls]]
  (each [_ lsp (ipairs servers)]
    ((. (. nvim_lsp lsp) :setup) {:capabilities lsp-defaults.capabilities
                                  : on_attach
                                  :init_options {:onlyAnalyzeProjectsWithOpenFiles true
                                                 :suggestFromUnimportedLibraries false
                                                 :closingLabels true}})))

nil
