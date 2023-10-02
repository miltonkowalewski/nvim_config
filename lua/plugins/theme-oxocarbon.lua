
local M = {}

M.lazy =
-- https://github.com/judaew/ronny.nvim
{
  "nyoom-engineering/oxocarbon.nvim",
  lazy = false,
  priority = 1000,
}

M.load = function ()
  vim.opt.background = "dark" -- set this to dark or light
  vim.cmd.colorscheme("oxocarbon")
  -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return M
