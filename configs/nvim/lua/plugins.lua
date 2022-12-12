local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")
  -- themes
  use("sainnhe/gruvbox-material")

  -- keymaps
  use({
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({ show_keys = false, show_help = false })
    end,
  })
  use({
    "mrjones2014/legendary.nvim",
    requires = { "nvim-telescope/telescope.nvim", "stevearc/dressing.nvim" },
  })
  use("ggandor/leap.nvim")

  -- editing
  use({
    "nvim-pack/nvim-spectre",
    requires = "nvim-lua/plenary.nvim",
  })
  use({
    "ThePrimeagen/refactoring.nvim",
    requires = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
  })
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({})
    end,
  })
  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end,
  })
  use("windwp/nvim-ts-autotag")
  use("gpanders/editorconfig.nvim")
  use({
    "pwntester/octo.nvim",
    config = function()
      require("octo").setup({})
    end,
    requires = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter", "kyazdani42/nvim-web-devicons" },
  })

  -- languages
  use("folke/neodev.nvim")
  use("rust-lang/rust.vim")
  use("jose-elias-alvarez/typescript.nvim")
  use("vmchale/just-vim")
  use({
    "simrat39/rust-tools.nvim",
    config = function()
      require("rust-tools").setup({ tools = { inlay_hints = { only_current_line = true } } })
    end,
    requires = "neovim/nvim-lspconfig",
  })

  -- LSP and Treesitter
  use("neovim/nvim-lspconfig")
  use("jose-elias-alvarez/null-ls.nvim")
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        highlight = { enable = true },
      })
    end,
  })
  use({
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup({})
    end,
    requires = "kyazdani42/nvim-web-devicons",
  })
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "davidsierradz/cmp-conventionalcommits",
    },
  })
  use({
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup()
    end,
  })
  use({
    "kosayoda/nvim-lightbulb",
    requires = "antoinemadec/FixCursorHold.nvim",
    config = function()
      require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
    end,
  })
  use({
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
  })

  -- UI
  use("elihunter173/dirbuf.nvim")
  use({
    "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").setup({ defaults = { file_ignore_patterns = { "^.git/" } } })
    end,
    requires = "nvim-lua/plenary.nvim",
  })
  use({
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          globalstatus = true,
          theme = "gruvbox-material",
          component_separators = "",
          section_separators = "",
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  })
  use({
    "romgrk/barbar.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  })
  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({})
    end,
  })
  use({
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
      require("notify").setup({ background_colour = "#000000" })
    end,
  })
  use({
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup({})
    end,
    requires = "nvim-lua/plenary.nvim",
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
