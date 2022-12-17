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
