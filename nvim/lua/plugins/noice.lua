-- lazy.nvim
return {
  "folke/noice.nvim",
  event = function()
    return "BufReadPre"
  end,
  enabled = true,
  opts = {
    routes = {
      -- HACK: Suppressing errors of a certain type
      {
        filter = {
          event = "notify",
          find = "Request textDocument/inlayHint failed",
        },
        opts = { skip = true },
      },
    },
    presets = {
      -- you can enable a preset by setting it to true, or a table that will override the preset config
      -- you can also add custom presets that you can enable/disable with enabled=true
      bottom_search = false, -- use a classic bottom cmdline for search
      command_palette = false, -- position the cmdline and popupmenu together
      long_message_to_split = false, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
    },
    cmdline = {
      enabled = true, -- enables the Noice cmdline UI
      view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
      opts = {}, -- global options for the cmdline. See section on views
    },
    messages = {
      enabled = true, -- enables the Noice messages UI
      view = "notify", -- default view for messages
      view_error = "notify", -- view for errors
      view_warn = "notify", -- view for warnings
      view_history = "messages", -- view for :messages
      view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
    },
    lsp = {
      progress = {
        enabled = true,
      },
      hover = {
        enabled = false,
      },
      message = {
        enabled = false,
      },
      signature = {
        enabled = false,
      },
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
}
