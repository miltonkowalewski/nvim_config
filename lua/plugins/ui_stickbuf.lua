local M = {}

M.lazy =
-- https://github.com/stevearc/stickybuf.nvim
{
  "stevearc/stickybuf.nvim",
  config = function ()
    require("stay-centered").setup()
  end,
}

return M
