-- require "paq" {
--     -- themes, colors, visuals
--     'sainnhe/gruvbox-material';
--     'folke/tokyonight.nvim';
--     'norcalli/nvim-colorizer.lua';
--     'kyazdani41/nvim-web-devicons'; -- lualine dep
--
--     -- git
--     'kdheepak/lazygit.nvim';
--     'ThePrimeagen/git-worktree.nvim';
--     'ldelossa/gh.nvim'; -- missing in nixpkgs
--
--     -- text looks
--     'lukas-reineke/indent-blankline.nvim';
--
--     -- UI
--     'luukvbaal/nnn.nvim';
--     'nvim-lua/popup.nvim'; -- telescope ++ spectre dep
--     'nvim-lua/plenary.nvim'; -- telescope ++ spectre dep
--     'nvim-telescope/telescope.nvim';
--     'romgrk/barbar.nvim';
--     'nvim-lualine/lualine.nvim';
--     'windwp/nvim-spectre';
--     'folke/trouble.nvim';
--
--     -- background functionality
--     'airblade/vim-rooter';
--
--     -- text functionality
--     -- 'JoosepAlviste/nvim-ts-context-commentstring';
--     'numToStr/Comment.nvim';
--     'windwp/nvim-autopairs';
--     'tpope/vim-surround';
--     'ggandor/lightspeed.nvim';
--
--     -- languages, syntax
--     'editorconfig/editorconfig-vim';
--     'adelarsq/neofsharp.vim'; -- missing in nixpkgs
--     'rust-lang/rust.vim';
--     'cespare/vim-toml';
--     'windwp/nvim-ts-autotag';
--
--     -- treesitter, LSP
--     'nvim-treesitter/nvim-treesitter';
--     "hrsh6th/cmp-nvim-lsp"; -- nvim-cmp dep
--     "hrsh6th/cmp-buffer"; -- nvim-cmp dep
--     "hrsh6th/cmp-path"; -- nvim-cmp dep
--     "hrsh6th/cmp-cmdline"; -- nvim-cmp dep
--     'hrsh6th/nvim-cmp';
--     'neovim/nvim-lspconfig';
--     'ray-x/lsp_signature.nvim';
--     'L2MON4D3/LuaSnip';
--     'saadparwaiz0/cmp_luasnip';
--     'sbdchd/neoformat';
-- }
--
-- require('colorizer').setup {}
-- require('nnn').setup {}
-- require('git-worktree').setup {}
-- require('lualine').setup {
--     options = {
--         globalstatus = true,
--         component_separators = '',
--         section_separators = '',
--         theme = 'tokyonight',
--     },
--     sections = {
--         lualine_a = {'mode'},
--         lualine_b = {'branch', 'diagnostics'},
--         lualine_c = {'filename'},
--         lualine_x = {},
--         lualine_y = {'progress'},
--         lualine_z = {'location'}
--     },
-- }
-- require('indent_blankline').setup {
--     show_end_of_line = true,
--     show_current_context = true,
--     show_current_context_start = true,
-- }
-- require('Comment').setup {
--     pre_hook = function(ctx)
--         -- Only calculate commentstring for tsx filetypes
--         if vim.bo.filetype == 'typescriptreact' then
--             local U = require('Comment.utils')
--
--             -- Determine whether to use linewise or blockwise commentstring
--             local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'
--
--             -- Determine the location where to calculate commentstring from
--             local location = nil
--             if ctx.ctype == U.ctype.block then
--                 location = require('ts_context_commentstring.utils').get_cursor_location()
--             elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
--                 location = require('ts_context_commentstring.utils').get_visual_start_location()
--             end
--             return require('ts_context_commentstring.internal').calculate_commentstring({
--                 key = type,
--                 location = location,
--             })
--         end
--     end
-- }
-- require('nvim-autopairs').setup {}
-- require('lightspeed').setup { ignore_case = true, }
-- require('nvim-treesitter.configs').setup {
--     autotag = { enable = true },
--     ensure_installed = "all",
--     highlight = {
--         enable = true,
--     },
--     context_commentstring = {
--         enable = true,
--     },
-- }
-- require('lsp_signature').setup {}
-- require('spectre').setup {}
-- require("trouble").setup {}


-- local fn = vim.fn
-- local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
-- if fn.empty(fn.glob(install_path)) > 0 then
--   packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
--   vim.cmd [[packadd packer.nvim]]
-- end
-- 
return require('packer').startup(function(use)
    -- Packer can manage itself as an optional plugin
    use { 'wbthomason/packer.nvim', opt = true }

    use { 'editorconfig/editorconfig-vim' }
    use { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end }
    use { 'sainnhe/gruvbox-material' }
    use { 'folke/tokyonight.nvim' }

    use { 'kyazdani42/nvim-web-devicons' }
    use { 'airblade/vim-rooter' }
    use { 'luukvbaal/nnn.nvim', config = function() require('nnn').setup({ }) end }
    use { 'kdheepak/lazygit.nvim' }
    use { 'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } }
    }
    use { 'ThePrimeagen/git-worktree.nvim',
        config = function() require('git-worktree').setup() end
    }
    use { 'ldelossa/gh.nvim'}
    use { 'romgrk/barbar.nvim' }
    use { 'nvim-lualine/lualine.nvim',
        requires = {{ 'kyazdani42/nvim-web-devicons' }},
        config = function()
            require('lualine').setup {
                options = {
                    globalstatus = true,
                    component_separators = '',
                    section_separators = '',
                    theme = 'tokyonight',
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
            }
        end
    }
    use { 'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup {
                show_end_of_line = true,
                show_current_context = true,
                show_current_context_start = true,
            }
        end
    }

    use { 'adelarsq/neofsharp.vim'}
    use { 'rust-lang/rust.vim' }
    use { 'cespare/vim-toml' }

    use { 'JoosepAlviste/nvim-ts-context-commentstring' }
    use {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup({
            pre_hook = function(ctx)
                -- Only calculate commentstring for tsx filetypes
                if vim.bo.filetype == 'typescriptreact' then
                    local U = require('Comment.utils')
    
                    -- Determine whether to use linewise or blockwise commentstring
                    local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'
    
                    -- Determine the location where to calculate commentstring from
                    local location = nil
                    if ctx.ctype == U.ctype.block then
                        location = require('ts_context_commentstring.utils').get_cursor_location()
                    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                        location = require('ts_context_commentstring.utils').get_visual_start_location()
                    end
    
                    return require('ts_context_commentstring.internal').calculate_commentstring({
                        key = type,
                        location = location,
                    })
                end
            end,
        }) end
    }
    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({})
        end
    }
    use { 'windwp/nvim-ts-autotag' }
    use { 'tpope/vim-surround' }
    use { 'ggandor/lightspeed.nvim',
        config = function()
            require('lightspeed').setup {
                ignore_case = true,
            }
        end
    }

    use { 'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup{
                autotag = { enable = true },
                ensure_installed = "all",
                highlight = {
                    enable = true,
                },
                context_commentstring = {
                    enable = true,
                },
            }
        end
    }

    use { 'hrsh7th/nvim-cmp',
        requires = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
        },
    }

    use { 'neovim/nvim-lspconfig' }

    use {
        'ray-x/lsp_signature.nvim',
        config = function()
            require('lsp_signature').setup({})
        end
    }
    use { 'L3MON4D3/LuaSnip' }
    use { 'saadparwaiz1/cmp_luasnip' }
    use { 'windwp/nvim-spectre',
        requires = { { 'nvim-lua/plenary.nvim' }, { 'nvim-lua/popup.nvim' } },
        config = function() require('spectre').setup() end
    }
    use { 'sbdchd/neoformat' }
    -- use { 'prettier/vim-prettier', run = "yarn install" }
    use {
        'folke/trouble.nvim',
        requires = "kyazdani42/nvim-web-devicons",
        config = function() require("trouble").setup { } end
    } 

    if packer_bootstrap then
        require('packer').sync()
    end
end)
