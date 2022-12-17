local function bootstrap(url, ref)
  local name = url:gsub(".*/", "")
  local path = vim.fn.stdpath([[data]]) .. "/site/pack/" .. "paq" .. "/start/" .. name

  if vim.fn.isdirectory(path) == 0 then
    print(name .. ": installing in data dir...")

    vim.fn.system({ "git", "clone", url, path })
    if ref then
      vim.fn.system({ "git", "-C", path, "checkout", ref })
    end

    vim.cmd([[redraw]])
    print(name .. ": finished installing")
  end
end

bootstrap("https://github.com/savq/paq-nvim")
vim.cmd("packadd paq-nvim")
