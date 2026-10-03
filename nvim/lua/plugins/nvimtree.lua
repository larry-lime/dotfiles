return {
  "https://github.com/nvim-tree/nvim-tree.lua",
  cmd = "NvimTreeToggle",
  keys = {
    {
      "<leader>nt",
      function()
        require("nvim-tree.api").tree.toggle({ find_file = false, update_root = false, focus = true })
      end,
      desc = "Nvim Tree Toggle",
    },
    {
      "<D-s>", -- Command+s
      function()
        require("nvim-tree.api").tree.toggle({ find_file = false, update_root = false, focus = true })
      end,
      desc = "Nvim Tree Toggle",
    },
    {
      "<leader>e",
      function()
        require("nvim-tree.api").tree.toggle({ find_file = false, update_root = false, focus = true })
      end,
      desc = "Nvim Tree Toggle",
    },
    {
      "<leader>nf",
      function()
        require("nvim-tree.api").tree.find_file({ update_root = true, open = true, focus = true })
      end,
      desc = "Nvim Tree Toggle",
    },
  },

  opts = {},
}
