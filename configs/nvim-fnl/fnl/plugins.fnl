(require-macros :hibiscus.packer)
(import-macros {: plugin-setup} :util-macros)

(packer-setup)
;; -----------
;; PLUGIN LIST
;; -----------

;; fnlfmt: skip
(packer
  ;; handled by the packer-setup macro
  ;; (use! :wbthomason/packer.nvim)
  (use! :udayvir-singh/tangerine.nvim)
  (use! :udayvir-singh/hibiscus.nvim)

  ;; themes
  (use! :sainnhe/gruvbox-material)

  ;; neorg
  (use! :nvim-neorg/neorg
        :requires :nvim-lua/plenary.nvim
        :after :nvim-treesitter
        :ft :norg
        :requires [:nvim-lua/plenary.nvim]
        :config #(plugin-setup :neorg {:load {:core.defaults {}
                                              :core.norg.dirman {:config {:workspaces {:work "~/notes/work/"
                                                                          :home "~/notes/home/"
                                                                          :hedis "~/notes/hedis/"
                                                                          :blog "~/notes/blog"
                                                                          :myosotis "~/notes/myosotis/"}}}}}))

  ;; configuration
  (use! :folke/which-key.nvim)
  (use! :mrjones2014/legendary.nvim
        :requires [:nvim-telescope/telescope.nvim :stevearc/dressing.nvim])

  ;; functionality
  (use! :nvim-neo-tree/neo-tree.nvim
        :branch "v2.x"
        :requires [:nvim-lua/plenary.nvim :kyazdani42/nvim-web-devicons :MunifTanjim/nui.nvim])
        :config #(plugin-setup :neo-tree {:window {:mappings {:x :open_split :v :open_vsplit}}})

  (use! :nvim-treesitter/nvim-treesitter
        :run ":TSUpdate"
        :config #(plugin-setup :nvim-treesitter.configs {:autotag {:enable true}
                                                         :ensure_installed :all
                                                         :highlight {:enable true}
                                                         :rainbow {:enable true
                                                                   :external_mode true
                                                                   :max_file_lines nil}}))

  ;; editing
  (use! :nvim-pack/nvim-spectre
        :requires :nvim-lua/plenary.nvim)
  (use! :ThePrimeagen/refactoring.nvim
        :requires [:nvim-lua/plenary.nvim :nvim-treesitter/nvim-treesitter])
  (use! :numToStr/Comment.nvim
        :config #(plugin-setup :Comment {}))
  (use! :windwp/nvim-autopairs
        :config #(plugin-setup :nvim-autopairs {}))
  (use! :windwp/nvim-ts-autotag)
  (use! :kylechui/nvim-surround
        :config #(plugin-setup :nvim-surround {}))
  (use! :gpanders/editorconfig.nvim)
  (use! :kdheepak/lazygit.nvim)
  (use! :pwntester/octo.nvim
        :requires [:nvim-lua/plenary.nvim :nvim-telescope/telescope.nvim :kyazdani42/nvim-web-devicons]
        :config #(plugin-setup :octo {}))

  ;; languages
  ;; (use! :nathom/filetype.nvim
  ;;       :config #(plugin-setup :filetype {:overrides {:extensions {:bb :clojure} :shebang {:bb :clojure}}}))
  (use! :rust-lang/rust.vim)
  (use! :simrat39/rust-tools.nvim
        :requires :neovim/nvim-lspconfig
        :config #(plugin-setup :rust-tools {
                               :server {:settings {:rust-analyzer {:checkOnSave {:command "clippy -- -A clippy::needless_return -A clippy::op_ref"}}}}
                               }))
  (use! :jose-elias-alvarez/typescript.nvim)
  (use! :imsnif/kdl.vim)

  ;; LSP
  (use! :neovim/nvim-lspconfig)
  (use! :ray-x/lsp_signature.nvim)
  (use! :jose-elias-alvarez/null-ls.nvim)
  (use! :folke/trouble.nvim
        :requires :kyazdani42/nvim-web-devicons
        :config #(plugin-setup :trouble {}))
  (use! :hrsh7th/nvim-cmp
        :requires [:hrsh7th/cmp-buffer
                   :hrsh7th/cmp-calc
                   :hrsh7th/cmp-cmdline
                   :hrsh7th/cmp-path
                   :hrsh7th/cmp-nvim-lsp
                   :saadparwaiz1/cmp_luasnip
                   :L3MON4D3/LuaSnip
                   :rafamadriz/friendly-snippets
                   :davidsierradz/cmp-conventionalcommits]
        )

  ;; Telescope
  (use! :nvim-telescope/telescope.nvim
        :requires :nvim-lua/plenary.nvim)

  ;; UI
  (use! :nvim-lualine/lualine.nvim
        :requires [:kyazdani42/nvim-web-devicons :WhoIsSethDaniel/lualine-lsp-progress.nvim]
        :config #(plugin-setup :lualine {:options {:globalstatus true
                                                   :theme :gruvbox-material
                                                   :component_separators ""
                                                   :section_separators ""}
                                         :sections {:lualine_a [:mode]
                                                    :lualine_b [:branch :diagnostics]
                                                    :lualine_c [:filename]
                                                    :lualine_x [:lsp_progress]
                                                    :lualine_y [:progress]
                                                    :lualine_z [:location]
                                                    }}))
  (use! :romgrk/barbar.nvim
        :requires :kyazdani42/nvim-web-devicons)
  (use! :norcalli/nvim-colorizer.lua
        :config #(plugin-setup :colorizer {}))
  (use! :rcarriga/nvim-notify
        :config (fn [] (set vim.notify (require :notify)) (plugin-setup :notify {:background_colour "#000000"})))
  (use! :p00f/nvim-ts-rainbow)
  (use! :folke/todo-comments.nvim
        :requires :nvim-lua/plenary.nvim
        :config #(plugin-setup :todo-comments {}))
  )
