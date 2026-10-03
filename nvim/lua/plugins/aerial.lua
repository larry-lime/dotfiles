return {
  "stevearc/aerial.nvim",
  lazy = true,
  opts = {
    nav = {
      border = "rounded",
      max_height = 0.9,
      min_height = { 10, 0.1 },
      max_width = 0.5,
      min_width = { 0.2, 20 },
      win_opts = {
        cursorline = true,
        winblend = 10,
      },
      autojump = true,
      preview = false,
      keymaps = {
        ["<CR>"] = "actions.jump",
        ["q"] = "actions.close",
        ["<2-LeftMouse>"] = "actions.jump",
        ["<C-v>"] = "actions.jump_vsplit",
        ["<C-s>"] = "actions.jump_split",
        ["h"] = "actions.left",
        ["l"] = "actions.right",
      },
    },
  },
  keys = {
    { "<leader>nv", "<CMD>:AerialNavToggle<CR>", desc = "Aerial (Nav)" },
  },
}
