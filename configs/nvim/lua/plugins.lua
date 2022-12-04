local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- themes
  use 'sainnhe/gruvbox-material'

  -- keymaps
  use {
    'folke/which-key.nvim',
    config = function() require('which-key').setup({ show_keys = false, show_help = false }) end,
  }
  use {
    'mrjones2014/legendary.nvim',
    requires = { 'nvim-telescope/telescope.nvim', 'stevearc/dressing.nvim' },
  }
  use 'ggandor/leap.nvim'

  -- editing
  use {
    'nvim-pack/nvim-spectre',
    requires = 'nvim-lua/plenary.nvim',
  }
  use {
    'ThePrimeagen/refactoring.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
  }
  use {
    'numToStr/Comment.nvim',
    config = function() require('which-key').setup({}) end,
  }
  use {
    'kylechui/nvim-surround',
    config = function() require('nvim-surround').setup({}) end,
  }
  use 'windwp/nvim-ts-autotag'
  use 'gpanders/editorconfig.nvim'
  use {
    'pwntester/octo.nvim',
    config = function() require('octo').setup({}) end,
    requires = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter', 'kyazdani42/nvim-web-devicons' },
  }

  -- languages
  use 'folke/neodev.nvim'
  use 'rust-lang/rust.vim'
  use 'jose-elias-alvarez/typescript.nvim'
  use 'vmchale/just-vim'
  use {
    'simrat39/rust-tools.nvim',
    config = function() require('rust-tools').setup({ tools = { inlay_hints = { only_current_line = true } } }) end,
    requires = 'neovim/nvim-lspconfig',
  }

  -- LSP and Treesitter
  use 'neovim/nvim-lspconfig'
  use 'jose-elias-alvarez/null-ls.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use {
    'folke/trouble.nvim',
    config = function() require('trouble').setup({}) end,
    requires = 'kyazdani42/nvim-web-devicons',
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
      'davidsierradz/cmp-conventionalcommits',
    },
  }

  -- UI
  use 'elihunter173/dirbuf.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    config = function() require('telescope').setup({ defaults = { file_ignore_patterns = { "^.git/" } } }) end,
    requires = 'nvim-lua/plenary.nvim',
  }
  use {
    'folke/noice.nvim',
    config = function() require('noice').setup({
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        filter = {
          warning = true,
          find = "multiple different client offset_encodings",
        },
        opts = {
          skip = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    }) end,
    requires = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
  }
  use {
    'nvim-lualine/lualine.nvim',
    config = function() require('lualine').setup({
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
    }) end,
  }
  use {
    'romgrk/barbar.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
  }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup({}) end
  }
  use {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require('notify')
      require('notify').setup({ background_colour = "#000000" })
    end,
  }
  use {
    'folke/todo-comments.nvim',
    config = function() require('todo-comments').setup({}) end,
    requires = 'nvim-lua/plenary.nvim',
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
