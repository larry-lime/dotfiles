-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- Disable autoformat for lua files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "typescriptreact", "typescript", "python", "rust", "markdown", "yaml" },
  callback = function()
    vim.b.autoformat = false
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.lalrpop" },
  command = "set filetype=lalrpop | TSBufEnable highlight",
})

-- TODO: Move to LSP when I have the time
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "move" },
  callback = function()
    vim.lsp.start({
      name = "move-analyzer",
      cmd = { "move-analyzer" },
      root_dir = vim.fs.root(0, { "Move.toml" }),
    })
  end,
})

-- TODO: Move to LSP when I have the time
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "move" },
  callback = function()
    vim.lsp.start({
      name = "move-analyzer",
      cmd = { "move-analyzer" },
      root_dir = vim.fs.root(0, { "Move.toml" }),
    })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "vimwiki" },
  command = "set filetype=markdown",
})

-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = { "*mly" },
--   command = "TSDisable highlight | LspStop",
-- })

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "*.tex" },
  command = "set wrap",
})

-- Auto-reload files when changed externally
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  pattern = "*",
  command = "checktime",
})

-- Check for file changes on cursor hold
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  command = "checktime",
})

-- Optional: Show notification when file is reloaded
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    vim.notify("File reloaded", vim.log.levels.INFO)
  end,
})

vim.filetype.add({
  pattern = {
    [".*/nginx/sites%-available/.*"] = "nginx",
    [".*/nginx/sites%-enabled/.*"] = "nginx",
  },
})
-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   pattern = { "*" },
--   callback = function()
--     display_filename_with_modified_and_tab()
--   end,
-- })

-- vim.api.nvim_create_autocmd({ "BufLeave" }, {
--   pattern = { "*.lua" },
--   callback = function()
--     print(vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "modified"))
--   end,
-- })
