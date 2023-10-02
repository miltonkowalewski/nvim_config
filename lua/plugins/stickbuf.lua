local M = {}

M.lazy = {
  "stevearc/stickybuf.nvim",
  config = function ()
    require("stay-centered").setup()
  end,
}

return M
