-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Remove from system clipboard
local options = {
  clipboard = "unnamedplus", -- unnamedplus
  termguicolors = true,
  laststatus = 0,
  lazyredraw = false,
  showtabline = 0,
  winbar = "%m %t [%{tabpagenr()}]",
  autoread = true, -- Auto-reload files changed outside of Neovim
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
