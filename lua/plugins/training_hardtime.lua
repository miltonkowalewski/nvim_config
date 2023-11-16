local M = {}

M.lazy =
-- https://github.com/m4xshen/hardtime.nvim
{
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  opts = {
    -- https://github.com/m4xshen/hardtime.nvim#options
  },
  config = function (_, opts)
    require("hardtime").setup(opts)
  end,
  keys = {
    { "<leader>0ht", ":Hardtime toggle<CR>", desc = "Toggle (establish good command workflow and habit)" },
  }
}

return M
