local M = {}

M.lazy = {
-- https://github.com/xiyaowong/transparent.nvim
  "xiyaowong/transparent.nvim",
  cmd = { "TransparentToggle", "TransparentDisable", "TransparentEnable" },
  init = function ()
    vim.api.nvim_command(":TransparentEnable")
  end,
  config = function (_, opts)
    require("transparent").setup({ -- Optional, you don't have to run setup.
      groups = { -- table: default groups
        'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
        'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
        'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
        'SignColumn', 'CursorLineNr', 'EndOfBuffer',
      },
      extra_groups = {}, -- table: additional groups that should be cleared
      exclude_groups = {}, -- table: groups you don't want to clear
    })
  end
}

return M
