-- Outbox support: `outbox send` (tmux prefix+Enter / Ghostty cmd+enter)
-- resets the compose file after sending it. Watch the file and reload the
-- buffer quietly when that happens, cursor on the `to:` line.
-- The keybinds live in tmux/Ghostty; see ~/.local/bin/outbox.

local file = vim.fn.stdpath("state") .. "/outbox/compose.md"
local watcher

vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("outbox", { clear = true }),
  pattern = file,
  callback = function(ev)
    if watcher then watcher:stop() end
    watcher = vim.uv.new_fs_event()
    watcher:start(file, {}, vim.schedule_wrap(function()
      local buf = ev.buf
      if not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].modified then return end
      vim.api.nvim_buf_call(buf, function() vim.cmd("silent noautocmd edit!") end)
      local win = vim.fn.bufwinid(buf)
      if win ~= -1 and vim.api.nvim_buf_get_lines(buf, 1, 2, false)[1] == "to: " then
        vim.api.nvim_win_set_cursor(win, { 2, 4 })
      end
    end))
  end,
})
