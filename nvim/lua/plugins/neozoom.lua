return {
  "nyngwang/NeoZoom.lua",
  -- lazy = true,
  lazy = true,
  opts = {
    winopts = {
      offset = {
        -- NOTE: omit `top`/`left` to center the floating window vertically/horizontally.
        -- top = 0,
        -- left = 0.17,
        width = 1.00,
        height = 0.95,
      },
      -- NOTE: check :help nvim_open_win() for possible border values.
      border = "thicc", -- this is a preset, try it :)
    },
  },
  keys = {
    {
      "<leader>z",
      function()
        require("neo-zoom").neo_zoom({})
      end,
      desc = "Find Plugin File",
    },
  },
}
