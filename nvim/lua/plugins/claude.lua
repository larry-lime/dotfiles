return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for git operations
  },
  lazy = false,
  keys = {
    { "<leader>C", "<cmd>ClaudeCode<cr>", desc = "Claude code" },
  },
  config = function()
    require("claude-code").setup({
      window = {
        position = "vertical", -- Position of the window: "botright", "topleft", "vertical", "float", etc.
      },
    })
  end,
}
