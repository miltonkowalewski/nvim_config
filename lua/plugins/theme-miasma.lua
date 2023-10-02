local M = {}

M.lazy =
-- https://github.com/xero/miasma.nvim
{
  "xero/miasma.nvim",
  lazy = false,
  priority = 1000,
}

M.load = function ()
  vim.cmd("colorscheme miasma")
end

return M
