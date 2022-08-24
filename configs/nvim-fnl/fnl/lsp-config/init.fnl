(fn on_attach [client bufnr]
  (let [augroup (vim.api.nvim_create_augroup [:LspFormatting {}])]
    (when (client.supports.method :textDocument/formatting)
      (vim.api.nvim_clear_autocmds {:group augroup :buffer bufnr})
      (vim.api.nvim_create_autocmd [:BufWritePre
                                    {:group augroup
                                     :buffer bufnr
                                     :callback #(vim.lsp.buf.format {: bufnr
                                                                     :filter #(= $1
                                                                                 :null-ls)})}]))
    (when (client.server_capabilities.document_highlight)
      vim.api.nvim_exec
      ["hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
augroup lsp_document_highlight
autocmd! * <buffer>
augroup END"
       false])))

;; ;; fnlfmt: skip
;; (fn has_words_before []
;;   (let [(line col) (vim.api.nvim_win_get_cursor 0)]
;;     (print :hello)
;;     ;;(lua "return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match(\"%s\") == nil")
;;     ;; (lua "return col ~= 0")
;;     (and (not= col 0) (= (((((. (vim.api.nvim_buf_get_lines [0 (- line 1) line true]) 1) :sub) [col col]) :match) "\"%s\"") nil ))
;;     ))

(let [nvim_lsp (require :lspconfig)
      capabilities ((. (require :cmp_nvim_lsp) :update_capabilities) (vim.lsp.protocol.make_client_capabilities []))
      ;; cmp (require :cmp)
      luasnip (require :luasnip)
      types (require :luasnip.util.types)]
  (set capabilities.offsetEncoding [:uft-16])
  (set capabilities.textDocument
       {:completion {:completionItem {:snippetSupport true
                                      :preselectSupport true
                                      :tagSupport {:valueSet [1]}
                                      :deprecatedSupport true
                                      :insertReplaceSupport true
                                      :labelDetailSupport true
                                      :commitCharactersSupport true
                                      :resolveSupport {:properties [:documentation
                                                                    :detail
                                                                    :addtionalTextEdits]}
                                      :documentationFormat [:markdown]}}
        :codeAction {:dynamicRegistration false
                     :codeActionLiteralSupport {:codeActionKind {:valueSet [""
                                                                            :quickfix
                                                                            :refactor
                                                                            :refactor.extract
                                                                            :refactor.inline
                                                                            :refactor.rewrite
                                                                            :source
                                                                            :source.organizeImports]}}}})
  (luasnip.config.set_config {:history true
                              :updateevents "TextChanged,TextChangedI"
                              :enable_autosnippets true})
  ;; ((. (require :cmp_git) :setup) {})
  ;; (cmp.setup {:snippet {:expand #(luasnip.lsp_expand $1.body)}
  ;;             :mapping {:<c-n> (cmp.mapping (cmp.mapping.select_next_item []))
  ;;                       :<c-p> (cmp.mapping (cmp.mapping.select_prev_item []))}})
  ;; :mapping {:<c-n> (cmp.mapping [#(if (cmp.visible [])
  ;;                                     (cmp.select_next_item [])
  ;;                                     ;; else if
  ;;                                     (luasnip.expand_or_jumpable [])
  ;;                                     (luasnip.expand_or_jump [])
  ;;                                     ;; else
  ;;                                     ($1 []))
  ;;                                [:i :s]])}})
  ;;                       :<c-p> (cmp.mapping [#(if (cmp.visible [])
  ;;                                                 (cmp.select_prev_item [])
  ;;                                                 ;; else if
  ;;                                                 (luasnip.jumpable [-1])
  ;;                                                 (luasnip.jump [-1])
  ;;                                                 ;; else
  ;;                                                 ($1 []))
  ;;                                            [:i :s]])
  ;;                       :<c-k> (cmp.mapping [#(if (luasnip.expand_or_jumpable [])
  ;;                                                 (luasnip.expand_or_jump []))
  ;;                                            [:i :s]])
  ;;                       :<c-j> (cmp.mapping [#(if (luasnip.jumpable [-1])
  ;;                                                 (luasnip.jump [-1]))
  ;;                                            [:i :s]])
  ;;                       :<c-l> (cmp.mapping [#(if (luasnip.choice_active [])
  ;;                                                 (luasnip.change_choice [1]))])
  ;;                       :<c-d> (cmp.mapping [(cmp.mapping.scroll_docs [-4])
  ;;                                            {:i :c}])
  ;;                       :<c-f> (cmp.mapping [(cmp.mapping.scroll_docs [4])
  ;;                                            {:i :c}])
  ;;                       :<c-space> (cmp.mapping.complete [])
  ;;                       :<c-e> (cmp.mapping.close [])
  ;;                       :<c-i> (cmp.mapping.confirm {:select true})}
  ;;             :sources (cmp.config.sources [{:name :nvim_lsp}
  ;;                                           {:name :luasnip}
  ;;                                           {:name :git}
  ;;                                           {:name :buffer}])})
  ;; (cmp.setup.cmdline ["/" {:sources [{:name :buffer}]}])
  ;; (cmp.setup.cmdline [":"
  ;;                     {:sources (cmp.config.sources [{:name :path}
  ;;                                                    {:name :cmdline}])}])
  ;; (set (. vim.lsp.handlers :textDocument/publishDiagnostics)
  ;;      (vim.lsp.with [vim.lsp.diagnostic.on_publish_diagnostics
  ;;                     {:virtual_text false}]))
  (let [servers [:ansiblels
                 :bashls
                 :clangd
                 :ccls
                 :csharp_ls
                 :cmake
                 :cssls
                 :fautocomplete
                 :gopls
                 :hls
                 :html
                 :julials
                 :pyright
                 :rnix
                 :svelte
                 :yamlls
                 :zls]]
    (each [_ server (ipairs servers)]
      ((. (. nvim_lsp server) :setup) {: capabilities
                                       : on_attach
                                       :init_options {:onlyAnalyzeProjectsWithOpenFiles true
                                                      :suggestFromUnimportedLibraries false
                                                      :closingLabels true}})))
  ((. (require :typescript) :setup) {})
  ((. (require :rust-tools) :setup) {})
  (let [nls (require :null-ls)
        nlsc nls.builtins.code_actions
        nlsd nls.builtins.diagnostics
        nlsf nls.builtins.formatting]
    (nls.setup {:sources [nlsc.eslint
                          nlsc.shellcheck
                          nlsc.statix
                          nlsd.ansiblelint
                          nlsd.chktext
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
                          (nlsf.prettier.with {:extra_filetypes [:svelte]})
                          nlsf.rustfmt
                          nlsf.shellharden
                          nlsf.stylish_haskell
                          nlsf.zigfmt]
                : on_attach})))
