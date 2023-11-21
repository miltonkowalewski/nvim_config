local M = {}

M.lazy =
-- https://github.com/cshuaimin/ssr.nvim
{
  "cshuaimin/ssr.nvim",
  keys = {
    {
      "<leader>R",
      function()
        require("ssr").open()
      end,
      mode = { "n", "x" },
      desc = "Structural Replace",
    },
  },
}

return M
