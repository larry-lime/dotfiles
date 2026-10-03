return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  enabled = true,
  opts = {
    options = {
      icons_enabled = true,
      theme = "auto",
      -- section_separators = { left = "", right = "" }, -- , , , , , , , 
      section_separators = { left = "", right = "" }, -- , , , , , , , ,
      component_separators = { left = ">", right = "" },
      disabled_filetypes = {},
      always_divide_middle = true,
      globalstatus = true,
    },
    sections = {
      lualine_z = { "tabs" },
    },
    -- winbar = {},
    --
    -- inactive_winbar = {
    --   lualine_a = {},
    --   lualine_b = {},
    --   lualine_c = {},
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {},
    -- },
  },
}
