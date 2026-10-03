return {
  "ibhagwan/fzf-lua",
  keys = {
    { "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (Root Dir)" },
    { "<leader>/", LazyVim.pick("live_grep", { root = false }), desc = "Grep (Root Dir)" },
    { "<leader>rg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
  },
}
