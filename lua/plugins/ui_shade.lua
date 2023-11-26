local M = {}

M.lazy =
-- https://github.com/sunjon/Shade.nvim
{
  "sunjon/shade.nvim",
  event = "VeryLazy",
  opts = {
    overlay_opacity = 50,
    opacity_step = 1,
  },
  config = function(_, opts)
    require'shade'.setup(opts)
  end
}

return M
