local fn = vim.fn
local packer_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(packer_path, _, _)) > 0 then
    packer_bootstrap = fn.system({
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', packer_path
    })
end
vim.cmd [[packadd packer.nvim]]

local packer = require('packer')
return packer.startup({
    function(use)
        use 'wbthomason/packer.nvim'

        -- theme
        use 'sainnhe/gruvbox-material'
        use 'olivercederborg/poimandres.nvim'

        -- neorg
        use {
            'nvim-neorg/neorg',
            requires = 'nvim-lua/plenary.nvim',
            config = function()
                require('neorg').setup {
                    load = {
                        ['core.defaults'] = {},
                        ['core.norg.dirman'] = {
                            config = {
                                workspaces = {
                                    work = '~/notes/work',
                                    home = '~/notes/home',
                                    hedis = '~/notes/hedis',
                                    blog = '~/notes/blog',
                                    myosotis = '~/notes/myosotis'
                                }
                            }
                        }
                    }
                }
            end
        }

        -- configuration
        use 'folke/which-key.nvim'
        use {
            'mrjones2014/legendary.nvim',
            requires = {
                'nvim-telescope/telescope.nvim', 'stevearc/dressing.nvim'
            }
        }

        -- functionality
        use {
            'akinsho/toggleterm.nvim',
            tag = 'v2.*',
            config = function() require('toggleterm').setup() end
        }
        use {
            'nvim-neo-tree/neo-tree.nvim',
            branch = 'v2.x',
            requires = {
                'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons',
                'MunifTanjim/nui.nvim'
            },
            config = function()
                require('neo-tree').setup({
                    window = {
                        mappings = { ['x'] = "open_split", ['v'] = "open_vsplit" }
                    }
                })
            end
        }
        use {
            'phaazon/hop.nvim',
            config = function()
                require('hop').setup({ multi_windows = true })
            end
        }
        use {
            'toppair/reach.nvim',
            config = function()
                require('reach').setup({ notifications = true })
            end
        }
        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            config = function()
                require('nvim-treesitter.configs').setup({
                    autotag = { enable = true },
                    ensure_installed = 'all',
                    highlight = { enable = true },
                    rainbow = {
                        enable = true,
                        external_mode = true,
                        max_file_lines = nil
                    }
                })
            end
        }
        -- use 'Olical/conjure'
        use {
            'danymat/neogen',
            requires = 'nvim-treesitter/nvim-treesitter',
            config = function() require('neogen').setup {} end
        }

        -- editing
        use { 'nvim-pack/nvim-spectre', requires = 'nvim-lua/plenary.nvim' }
        use {
            'ThePrimeagen/refactoring.nvim',
            requires = {
                'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter'
            }
        }
        use {
            'numToStr/Comment.nvim',
            config = function() require('Comment').setup() end
        }
        use {
            'windwp/nvim-autopairs',
            config = function() require('nvim-autopairs').setup() end
        }
        use 'windwp/nvim-ts-autotag'
        use {
            'kylechui/nvim-surround',
            config = function() require('nvim-surround').setup() end
        }
        use 'gpanders/editorconfig.nvim'

        -- git
        use {
            'TimUntersberger/neogit',
            requires = 'nvim-lua/plenary.nvim',
            config = function() require('neogit').setup() end
        }
        use {
            'pwntester/octo.nvim',
            requires = {
                'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim',
                'kyazdani42/nvim-web-devicons'
            },
            config = function() require('octo').setup() end
        }

        -- languages
        use {
            'nathom/filetype.nvim',
            config = function()
                require('filetype').setup {
                    overrides = {
                        extensions = { bb = "clojure" },
                        shebang = { bb = "clojure" }
                    }
                }
            end
        }
        use 'adelarsq/neofsharp.vim'
        use 'rust-lang/rust.vim'
        use { 'simrat39/rust-tools.nvim', requires = 'neovim/nvim-lspconfig' }
        use 'cespare/vim-toml'
        use 'jose-elias-alvarez/typescript.nvim'

        -- LSP
        use 'neovim/nvim-lspconfig'
        use 'ray-x/lsp_signature.nvim'
        use 'jose-elias-alvarez/null-ls.nvim'
        use {
            'folke/trouble.nvim',
            requires = 'kyazdani42/nvim-web-devicons',
            config = function() require('trouble').setup() end
        }
        use {
            'j-hui/fidget.nvim',
            requires = 'nvim-lua/plenary.nvim',
            config = function() require('fidget').setup() end
        }
        use {
            'hrsh7th/nvim-cmp',
            requires = {
                'hrsh7th/cmp-buffer', 'hrsh7th/cmp-calc', 'hrsh7th/cmp-cmdline',
                'hrsh7th/cmp-path', 'hrsh7th/cmp-nvim-lsp',
                'saadparwaiz1/cmp_luasnip', 'L3MON4D3/LuaSnip',
                'rafamadriz/friendly-snippets',
                'davidsierradz/cmp-conventionalcommits'
            }
        }
        use 'folke/lua-dev.nvim'

        -- Telescope
        use {
            'nvim-telescope/telescope.nvim',
            requires = 'nvim-lua/plenary.nvim'
        }
        use {
            'ahmedkhalf/project.nvim',
            requires = 'nvim-telescope/telescope.nvim',
            config = function()
                require('telescope').load_extension('projects')
                require('project_nvim').setup()
            end
        }
        use {
            'ThePrimeagen/git-worktree.nvim',
            requires = 'nvim-telescope/telescope.nvim',
            config = function()
                require('telescope').load_extension('git_worktree')
                require('git-worktree').setup()
            end
        }

        -- UI
        use {
            'nvim-lualine/lualine.nvim',
            requires = 'kyazdani41/nvim-web-devicons',
            config = function()
                require('lualine').setup({
                    options = {
                        globalstatus = true,
                        component_separators = '',
                        section_separators = '',
                        -- theme = 'gruvbox'
                        theme = 'poimandres'
                    },
                    sections = {
                        lualine_a = { 'mode' },
                        lualine_b = { 'branch', 'diagnostics' },
                        lualine_c = { 'filename' },
                        lualine_x = {},
                        lualine_y = { 'progress' },
                        lualine_z = { 'location' }
                    }
                })
            end
        }
        use { 'romgrk/barbar.nvim', requires = 'kyazdani41/nvim-web-devicons' }
        use {
            'norcalli/nvim-colorizer.lua',
            config = function() require('colorizer').setup() end
        }
        use {
            'rcarriga/nvim-notify',
            config = function()
                vim.notify = require('notify')
                require('notify').setup({ background_colour = "#000000" })
            end
        }
        use 'p00f/nvim-ts-rainbow'
        use {
            'folke/todo-comments.nvim',
            requires = 'nvim-lua/plenary.nvim',
            config = function() require('todo-comments').setup() end
        }

        if packer_bootstrap then packer.sync() end
    end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end
        }
    }
})