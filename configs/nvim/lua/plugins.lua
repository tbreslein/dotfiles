vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}

    -- Themes, colors, visual
    use {
        'norcalli/nvim-colorizer.lua',
        config = function() require('colorizer').setup {} end
    }
    use {'sainnhe/gruvbox-material'}
    use {'folke/tokyonight.nvim'}

    -- UI
    use {
        'nvim-neo-tree/neo-tree.nvim',
        branch = "v2.x",
        requires = {
            'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons',
            'MunifTanjim/nui.nvim'
        },
        config = function()
            require('neo-tree').setup {
                window = {
                    mappings = {['x'] = "open_split", ['v'] = "open_vsplit"}
                }
            }
        end
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = {{'kyazdani42/nvim-web-devicons'}},
        config = function()
            require('lualine').setup {
                options = {
                    globalstatus = true,
                    component_separators = '',
                    section_separators = '',
                    theme = 'gruvbox'
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                }
            }
        end
    }
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup {
                show_end_of_line = true,
                show_current_context = true,
                show_current_context_start = true
            }
        end
    }
    use {
        'b0o/incline.nvim',
        config = function() require('incline').setup {} end
    }
    use {
        'matbme/JABS.nvim',
        config = function()
            require('jabs').setup {keymap = {close = '<c-d>', h_split = 'x'}}
        end
    }
    use {
        'stevearc/dressing.nvim',
        config = function()
            require('dressing').setup {
                input = {winblend = 10},
                builtin = {winblend = 10}
            }
        end
    }
    use {
        'rcarriga/nvim-notify',
        config = function()
            require('notify').setup {background_colour = '#000000'}
        end
    }
    use {
        'ahmedkhalf/project.nvim',
        config = function() require('project_nvim').setup {} end
    }

    -- background functionality
    use {'airblade/vim-rooter'}
    use {'nathom/filetype.nvim'}

    -- git
    use {
        'TimUntersberger/neogit',
        requires = 'nvim-lua/plenary.nvim',
        config = function() require('neogit').setup {} end
    }
    use {
        'pwntester/octo.nvim',
        requires = {
            'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim',
            'kyazdani42/nvim-web-devicons'
        },
        config = function() require('octo').setup() end
    }

    -- functionality
    use {
        'akinsho/toggleterm.nvim',
        config = function() require('toggleterm').setup {} end
    }
    use {'nvim-telescope/telescope-file-browser.nvim'}
    use {
        'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'}
    }
    use {
        'ThePrimeagen/git-worktree.nvim',
        config = function() require('git-worktree').setup {} end
    }
    use {
        'ggandor/leap.nvim',
        requires = {'tpope/vim-repeat'},
        config = function() require('leap').set_default_keymaps() end
    }
    use {
        'windwp/nvim-spectre',
        requires = {{'nvim-lua/plenary.nvim'}, {'nvim-lua/popup.nvim'}},
        config = function() require('spectre').setup {} end
    }
    use {
        'folke/trouble.nvim',
        requires = "kyazdani42/nvim-web-devicons",
        config = function() require("trouble").setup {} end
    }
    use {
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup {window = {border = 'single'}}
        end
    }
    use {'mrjones2014/legendary.nvim'}

    -- neotest
    use {'nvim-neotest/neotest-go'}
    use {'haydenmeade/neotest-jest'}
    use {'nvim-neotest/neotest-python'}
    use {'rouge8/neotest-rust'}
    use {'nvim-neotest/neotest-vim-test'}
    use {
        'nvim-neotest/neotest',
        requires = {
            'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter',
            'antoinemadec/FixCursorHold.nvim'
        },
        config = function()
            require('neotest').setup {
                adapters = {
                    require('neotest-go'), require('neotest-jest'),
                    require('neotest-python'), require('neotest-rust'),
                    require('neotest-vim-test') {
                        ignore_file_types = {"python", "vim", "lua"}
                    }
                }
            }
        end
    }

    -- Languages
    use {'adelarsq/neofsharp.vim'}
    use {'rust-lang/rust.vim'}
    use {'simrat39/rust-tools.nvim'}
    use {'cespare/vim-toml'}
    use {'b0o/schemastore.nvim'}
    use {'jose-elias-alvarez/typescript.nvim'}
    use {'ray-x/go.nvim', requires = 'ray-x/guihua.lua'}
    use {'folke/lua-dev.nvim'}

    -- Formatting
    use {'editorconfig/editorconfig-vim'}
    use {'sbdchd/neoformat'}

    -- Editing
    use {
        'ThePrimeagen/refactoring.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'}, {'nvim-treesitter/nvim-treesitter'}
        },
        config = function() require('refactoring').setup {} end
    }
    use {'JoosepAlviste/nvim-ts-context-commentstring'}
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                pre_hook = function(ctx)
                    -- Only calculate commentstring for tsx filetypes
                    if vim.bo.filetype == 'typescriptreact' then
                        local U = require('Comment.utils')

                        -- Determine whether to use linewise or blockwise commentstring
                        local type =
                            ctx.ctype == U.ctype.line and '__default' or
                                '__multiline'

                        -- Determine the location where to calculate commentstring from
                        local location = nil
                        if ctx.ctype == U.ctype.block then
                            location =
                                require('ts_context_commentstring.utils').get_cursor_location()
                        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion ==
                            U.cmotion.V then
                            location =
                                require('ts_context_commentstring.utils').get_visual_start_location()
                        end

                        return
                            require('ts_context_commentstring.internal').calculate_commentstring(
                                {key = type, location = location})
                    end
                end
            })
        end
    }
    use {
        'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup {} end
    }
    use {'windwp/nvim-ts-autotag'}
    use {
        'kylechui/nvim-surround',
        config = function() require('nvim-surround').setup {} end
    }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                autotag = {enable = true},
                ensure_installed = "all",
                highlight = {enable = true},
                context_commentstring = {enable = true}
            }
        end
    }

    -- cmp, snips, lsp
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            {"hrsh7th/cmp-nvim-lsp"}, {"hrsh7th/cmp-buffer"},
            {"hrsh7th/cmp-path"}, {"hrsh7th/cmp-cmdline"},
            {"petertriho/cmp-git"}
        }
    }
    use {'neovim/nvim-lspconfig'}
    use {
        'ray-x/lsp_signature.nvim',
        config = function() require('lsp_signature').setup {} end
    }
    use {'L3MON4D3/LuaSnip'}
    use {'saadparwaiz1/cmp_luasnip'}
    use {'jose-elias-alvarez/null-ls.nvim', requires = 'nvim-lua/plenary.nvim'}
    use {
        'j-hui/fidget.nvim',
        config = function() require('fidget').setup {} end
    }
end)
