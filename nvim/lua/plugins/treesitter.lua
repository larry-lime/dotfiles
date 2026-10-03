-- local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
-- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
return {
  "nvim-treesitter/nvim-treesitter",
  -- TODO: Figure out how to not have this override other parsers
  -- config = function(_, opts)
  -- parser_config.move = {
  --   install_info = {
  --     url = "~/Github-Repos/Blockchain/tree-sitter-move", -- local path or git repo
  --     files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
  --     -- optional entries:
  --     -- branch = "main", -- default branch in case of git repo if different from master
  --     -- generate_requires_npm = false, -- if stand-alone parser without npm dependencies
  --     -- requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  --   },
  --   filetype = "move", -- if filetype does not match the parser name
  -- }
  -- end,
  keys = {
    -- {
    --   ",",
    --   function()
    --     ts_repeat_move.repeat_last_move_next()
    --   end,
    --   mode = { "n", "x", "o" },
    -- },
    -- {
    --   ";",
    --   function()
    --     ts_repeat_move.repeat_last_move_next()
    --   end,
    --   mode = { "n", "x", "o" },
    -- },
  },
  opts = {
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@conditional.inner",
          ["ic"] = "@conditional.outer",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["il"] = "@loop.inner",
          ["al"] = "@loop.outer",
          ["a/"] = "@comment.outer",
          ["iv"] = "@assignment.inner",
          ["av"] = "@assignment.outer",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
          ["]c"] = "@conditional.outer",
          ["]v"] = "@assignment.outer",
          ["]a"] = "@parameter.inner",
          ["]f"] = "@call.outer",
          ["]r"] = "@return.outer",
          ["]l"] = "@loop.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
          ["[c"] = "@conditional.outer",
          ["[v"] = "@assignment.outer",
          ["[a"] = "@parameter.inner",
          ["[A"] = "@parameter.outer",
          ["[f"] = "@call.outer",
          ["[r"] = "@return.outer",
          ["[l"] = "@loop.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
          ["]A"] = "@parameter.outer",
          ["]L"] = "@loop.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      -- goto_next = {
      --   [']i'] = "@conditional.inner",
      -- },
      -- goto_previous = {
      --   ['[i'] = "@conditional.inner",
      -- }
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  },
}
