local M = {}

M.lazy = {
  'akinsho/toggleterm.nvim',
  event = "VeryLazy",
  cmd = { "ToggleTerm" },
  version = "*",
  opts = {
    highlights = {
      Normal = { link = "Normal" },
      NormalNC = { link = "NormalNC" },
      NormalFloat = { link = "Normal" },
      FloatBorder = { link = "FloatBorder" },
      StatusLine = { link = "StatusLine" },
      StatusLineNC = { link = "StatusLineNC" },
      WinBar = { link = "WinBar" },
      WinBarNC = { link = "WinBarNC" },
    },
    size = 10,
    open_mapping = [[<c-\>]],
    shading_factor = 2,
    -- direction = "float",
    float_opts = {
      border = "rounded",
      highlights = { border = "Normal", background = "Normal" },
    },
    winbar = {
      enabled = false,
      name_formatter = function(term) --  term: Terminal
        return term.name
      end
    },
  },
  config = function (_, opts)
    require("toggleterm").setup(opts)
  end,
  keys = {
    { "<leader><S-t>", "<cmd>:ToggleTerm<cr>", desc = "Terminal" },
  }
}

return M
