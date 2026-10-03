return {
  "0xmovses/move.vim",
  -- Have it activate when I
  -- enter a '*.move' filetype extension
  enabled = false,
  event = function()
    return "BufEnter *.move"
  end,
  lazy = false,
}
