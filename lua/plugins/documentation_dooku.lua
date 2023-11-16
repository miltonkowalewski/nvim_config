local M = {}

M.lazy =
--  CODE DOCUMENTATION ------------------------------------------------------
--  dooku.nvim [html doc generator]
--  https://github.com/Zeioth/dooku.nvim
{
  "Zeioth/dooku.nvim",
  cmd = {
    "DookuGenerate",
    "DookuOpen",
    "DookuAutoSetup"
  },
  opts = {},
  keys = {
    { "<leader>0dg", mode = { "n" }, ":DookuGenerate<CR>" , desc="DookuGenerate (documentation)" },
    { "<leader>0do", mode = { "n" }, ":DookuOpen<CR>" , desc="DookuOpen (documentation)" },
  },
  config = function (_, opts)

  end
}

return M
