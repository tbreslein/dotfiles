require('bootstrap')
require('dep') {
  -- themes
  'sainnhe/gruvbox-material',

  -- keymaps
  {
    'folke/which-key.nvim',
    function() require('which-key').setup({ show_keys = false, show_help = false }) end,
  },
  {
    'mrjones2014/legendary.nvim',
    requires = { 'nvim-telescope/telescope.nvim', 'stevearc/dressing.nvim' },
  },
  'ggandor/leap.nvim',

  -- editing
  {
    'nvim-pack/nvim-spectre',
    requires = 'nvim-lua/plenary.nvim',
  },
  {
    'ThePrimeagen/refactoring.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
  },
  {
    'numToStr/Comment.nvim',
    function() require('which-key').setup({}) end,
  },
  {
    'kylechui/nvim-surround',
    function() require('nvim-surround').setup({}) end,
  },
  'windwp/nvim-ts-autotag',
  'gpanders/editorconfig.nvim',
  {
    'pwntester/octo.nvim',
    function() require('octo').setup({}) end,
    requires = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter', 'kyazdani42/nvim-web-devicons' },
  },

  -- languages
  'folke/neodev.nvim',
  'rust-lang/rust.vim',
  'jose-elias-alvarez/typescript.nvim',
  'vmchale/just-vim',
  {
    'simrat39/rust-tools.nvim'',
    function() require('rust-tools').setup({ tools = { inlay_hints = { only_current_line = true } } }) end,
    requires = 'neovim/lspconfig',
  },
  {
    'IndianBoy42/tree-sitter-just',
    function() require('tree-sitter-just').setup() end,
  },

  -- LSP and Treesitter
  'neovim/nvim-lspconfig',
  'jose-elias-alvarez/null-ls.nvim',
  {
    'nvim-treesitter/nvim-treesitter',
    function () vim.cmd(':TSUpdate') end,
  },
  {
    'folke/trouble.nvim',
    function() require('trouble').setup({}) end,
    requires = 'kyazdani42/nvim-web-devicons',
  },
  {
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
  },

  -- UI
  'elihunter173/dirbuf.nvim',
  {
    'nvim-telescope/telescope.nvim',
    function() require('telescope').setup({ defaults = { file_ignore_patterns = { "^.git/ " } } }) end,
    requires = 'nvim-lua/plenary.nvim',
  },
  {
    'folke/noice.nvim',
    function() require('noice').setup({
      routes = {
        filter = {
          warning = true,
          find = "multiple different client offset_encodings",
        },
        opts = {
          skip = true,
        },
      },
    }) end,
    requires = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
  },
  {
    'nvim-lualine/lualine.nvim',
    function() require('lualine').setup({
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
  },
  {
    'romgrk/barbar.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
  },
  {
    'norcalli/nvim-colorizer.lua',
    function() require('colorizer').setup({}) end
  },
  {
    'rcarriga/nvim-notify',
    function()
      vim.notify = require('notify')
      require('notify').setup({ background_colour = "#000000" })
    end,
  },
  {
    'folke/todo-comments.nvim',
    function() require('todo-comments').setup({}) end,
    requires = 'nvim-lua/plenary.nvim',
  },
}

