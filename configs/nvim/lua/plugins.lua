local fn = vim.fn
local packer_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(packer_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_path})
end
vim.cmd [[packadd packer.nvim]]

local packer = require('packer')
return packer.startup(function(use)
    use 'wbthomason/packer.nvim'

    -- theme
    use 'sainnhe/gruvbox-material'

    -- configuration
    use 'folke/which-key.nvim'
    use {'mrjones2014/legendary.nvim', requires = {'nvim-telescope/telescope.nvim', 'stevearc/dressing.nvim'}}

    -- functionality
    use {
        'akinsho/toggleterm.nvim',
        tag = 'v2.*',
        config = function()
            require('toggleterm').setup() 
        end
    }
    use {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x', 
        requires = {'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons', 'MunifTanjim/nui.nvim'},
        config = function() 
            require('neo-tree').setup({
                window = {
                    mappings = {
                        ['x'] = "open_split",
                        ['v'] = "open_vsplit",
                    }
                }
            })
        end
    }
    use 'ggandor/leap.nvim'
    use {
        'toppair/reach.nvim',
        config = function()
            require('reach').setup ({
                notifications = true
            })
        end
    }
    use {
        'nvim-treesitter/nvim-treesitter', 
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup ({
                autotag = {
                    enable = true
                },
                ensure_installed = 'all',
                highlight = {
		            enable = true,
		        },
            })
        end
    }

    -- editing
    use {'nvim-pack/nvim-spectre', requires = 'nvim-lua/plenary.nvim'}
    use {'ThePrimeagen/refactoring.nvim', requires = {'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter'}}
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup() 
        end
    }
    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup() 
        end
    }
    use {
        'windwp/nvim-ts-autotag',
        config = function() 
            require('nvim-autopairs').setup() 
        end
    }
    use {
        'kylechui/nvim-surround',
        config = function()
            require('nvim-surround').setup()
        end
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
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'kyazdani42/nvim-web-devicons',
        },
        config = function () require('octo').setup() end
    }

    -- languages
    use 'nathom/filetype.nvim'
    use 'adelarsq/neofsharp.vim'
    use 'rust-lang/rust.vim'
    use {'simrat39/rust-tools.nvim', requires = 'neovim/nvim-lspconfig'}
    use 'cespare/vim-toml'
    use 'jose-elias-alvarez/typescript.nvim'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'ray-x/lsp_signature.nvim'
    use 'jose-elias-alvarez/null-ls.nvim'
    use {
        'j-hui/fidget.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('fidget').setup()
        end
    }

    -- Telescope
    use {'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim'}
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
                    theme = 'gruvbox',
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {},
                    lualine_y = {'progress'},
                    lualine_z = {'location'},
                }
            })
        end
    }
    use {'romgrk/barbar.nvim', requires = 'kyazdani41/nvim-web-devicons'}
    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup() 
        end
    }
    use {
        'rcarriga/nvim-notify',
        config = function()
            vim.notify = require('notify')
            require('notify').setup ({
                background_colour = "#000000"
            })
        end
    }

    if packer_bootstrap then
        packer.sync()
    end
end)

