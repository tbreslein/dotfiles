-- bootstrap paq
local paq_path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if vim.fn.empty(vim.fn.glob(paq_path)) > 0 then
    vim.fn.system {
        'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git',
        paq_path
    }
end
vim.cmd [[packadd paq-nvim]]

-- bootstrap hotpot
local hotpot_path = vim.fn.stdpath('data') ..
                        '/site/pack/paqs/start/hotpot.nvim'

if vim.fn.empty(vim.fn.glob(hotpot_path)) > 0 then
    print("Could not find hotpot.nvim, cloning new copy to", hotpot_path)
    vim.fn.system({
        'git', 'clone', 'https://github.com/rktjmp/hotpot.nvim', hotpot_path
    })
    vim.cmd("helptags " .. hotpot_path .. "/doc")
end

-- Enable fnl/ support
require("hotpot")

-- Now you can load fennel code, so you could put the rest of your
-- config in a separate `~/.config/nvim/fnl/my_config.fnl` or
-- `~/.config/nvim/fnl/plugins.fnl`, etc.
require("config")
