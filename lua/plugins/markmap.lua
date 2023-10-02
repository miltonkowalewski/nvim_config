local M = {}

M.lazy =
--  [markdown markmap]
--  https://github.com/Zeioth/markmap.nvim
--  Note: If you change the build command, wipe ~/.local/data/nvim/lazy
{
  "Zeioth/markmap.nvim",
  ft = "markdown",
  build = "yarn global add markmap-cli",
  cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
  config = function(_, opts)
    require("markmap").setup(opts)
  end,
  keys = {
    { "<leader>0mm", mode = { "n" }, ":MarkmapOpen<CR>" , desc="MarkmapOpen (markdown as mindmaps)" },
  },
}

return M
