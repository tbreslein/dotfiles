(require-macros :hibiscus.vim)
(local paq (require :paq))

(paq [; fennel stuff
      :udayvir-singh/tangerine.nvim
      :udayvir-singh/hibiscus.nvim
      ; paq itself
      :savq/paq-nvim
      ; themes
      :sainnhe/gruvbox-material
      ; visuals
      :lukas-reineke/indent-blankline.nvim])

(color! gruvbox-material)
