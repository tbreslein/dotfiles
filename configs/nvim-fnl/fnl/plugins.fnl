(import-macros {: plugin-setup : telescope-load-extension} :util-macros)

(let [paq (require :paq)]
  (paq [;; paq itself
        :savq/paq-nvim
        ;; hotpot
        :rktjmp/hotpot.nvim
        ;;--- requirements for other plugins
        ; too many to count
        :nvim-lua/plenary.nvim
        ; neo-tree lualine octo trouble
        :kyazdani42/nvim-web-devicons
        ; neo-tree
        :MunifTanjim/nui.nvim
        ; telescope spectre
        :nvim-lua/popup.nvim
        ; leap
        :tpope/vim-repeat
        ; neotest
        :antoinemadec/FixCursorHold.nvim
        ; go.nvim
        :ray-x/guihua.lua
        ;;---------------------------------
        ;; configuration
        :folke/which-key.nvim
        :mrjones2014/legendary.nvim
        ;; functionality
        :akinsho/toggleterm.nvim
        ;; :matbme/JABS.nvim
        :nvim-neo-tree/neo-tree.nvim
        :ggandor/leap.nvim
        :Olical/conjure
        :toppair/reach.nvim
        ;; editing
        :windwp/nvim-spectre
        :ThePrimeagen/refactoring.nvim
        :numToStr/Comment.nvim
        :JoosepAlviste/nvim-ts-context-commentstring
        :windwp/nvim-autopairs
        :windwp/nvim-ts-autotag
        :kylechui/nvim-surround
        ;; git
        :TimUntersberger/neogit
        :pwntester/octo.nvim
        ;; languages
        :gpanders/editorconfig.nvim
        :nathom/filetype.nvim
        :adelarsq/neofsharp.vim
        :rust-lang/rust.vim
        :simrat39/rust-tools.nvim
        :cespare/vim-toml
        :jose-elias-alvarez/typescript.nvim
        :ray-x/go.nvim
        :b0o/schemastore.nvim
        ;; LSP + Treesitter + snips
        :folke/trouble.nvim
        :nvim-treesitter/nvim-treesitter
        :neovim/nvim-lspconfig
        :ray-x/lsp_signature.nvim
        :L3MON4D3/LuaSnip
        :jose-elias-alvarez/null-ls.nvim
        :j-hui/fidget.nvim
        ;; cmp
        ;; :hrsh7th/nvim-cmp
        ;; :hrsh7th/cmp-nvim-lsp
        ;; :hrsh7th/cmp-buffer
        ;; :hrsh7th/cmp-path
        ;; :hrsh7th/cmp-cmdline
        ;; :saadparwaiz1/cmp_luasnip
        ;; themes
        :sainnhe/gruvbox-material
        ;; telescope and telescope plugins
        :nvim-telescope/telescope.nvim
        :ahmedkhalf/project.nvim
        :ThePrimeagen/git-worktree.nvim
        ;; UI
        :nvim-lualine/lualine.nvim
        :romgrk/barbar.nvim
        ;; visuals
        :norcalli/nvim-colorizer.lua
        :rcarriga/nvim-notify
        :stevearc/dressing.nvim]))

(set vim.notify (require :notify))
(plugin-setup :notify {:background_colour "#000000"})

(plugin-setup :neo-tree {:window {:mappings {:x :open_split :v :open_vsplit}}})
(plugin-setup :lualine
              {:options {:globalstatus true
                         :component_separators ""
                         :section_separators ""
                         :theme :gruvbox}
               :sections {:lualine_a [:mode]
                          :lualine_b [:branch :diagnostics]
                          :lualine_c [:filename]
                          :lualine_x []
                          :lualine_y [:progress]
                          :lualine_z [:location]}})

(plugin-setup :Comment {:pre_hook (. (require :ts_context_commentstring.integrations.comment_nvim)
                                     :create_pre_hook)})

(plugin-setup :nvim-treesitter.configs
              {:autotag {:enable true}
               :ensure_installed :all
               :highlight {:enable true}})

(telescope-load-extension :git_worktree)
(telescope-load-extension :notify)
(telescope-load-extension :projects)
(telescope-load-extension :refactoring)

(let [actions (require :telescope.actions)
      bindings {:<c-x> actions.select_horizontal
                :<c-v> actions.select_vertical}
      previewers (require :telescope.previewers)]
  (plugin-setup :telescope
                {:defaults {:mappings {:n bindings :i bindings}
                            :vimgrep_arguments [:rg
                                                :--color=never
                                                :--with-filename
                                                :--line-number
                                                :--column
                                                :--smart-case
                                                :--hidden]
                            :file_ignore_patterns [:node_modules/.*
                                                   :.git/.*
                                                   :_site/.*]
                            :sorting_strategy :ascending
                            :set_env {:COLORTERM :truecolor}
                            :file_previewer previewers.vim_buffer_cat.new
                            :grep_previewer previewers.vim_buffer_vimgrep.new
                            :layout_config {:vertical {:mirror true}}}}))

(plugin-setup :dressing {:input {:winblend 50} :builtin {:winblend 50}})
(plugin-setup :which-key {:window {:border :single}})
(plugin-setup :reach {:notifications true})
(plugin-setup :bufferline {:animation false :closable false :clickable false})

;; process the plugins that just need their setup function to be called
(each [_ plugin (ipairs [:project_nvim
                         :neogit
                         :octo
                         :toggleterm
                         :git-worktree
                         :leap
                         :spectre
                         :trouble
                         :refactoring
                         :nvim-autopairs
                         :nvim-surround
                         :lsp_signature
                         :fidget])]
  (plugin-setup plugin {}))
