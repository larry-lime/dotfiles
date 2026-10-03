function Display_filename_with_modified_and_tab()
  local bufname = vim.api.nvim_buf_get_name(0)
  local modified = vim.api.nvim_buf_get_option(0, "modified")
  local tabnr = vim.api.nvim_tabpage_get_number(0)

  local modified_indicator = modified and "[+]" or ""
  local filename = vim.fn.fnamemodify(bufname, ":t")

  print(filename .. " " .. modified_indicator .. " [Tab " .. tabnr .. "]")
end
