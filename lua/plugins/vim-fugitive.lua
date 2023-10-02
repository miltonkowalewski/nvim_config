local M = {}

M.lazy = {
  "https://github.com/tpope/vim-fugitive",
  enabled = vim.fn.executable "git" == 1,
  dependencies = { "tpope/vim-rhubarb" },
  event = "VeryLazy",
  cmd = {
    "Gvdiffsplit",
    "Gdiffsplit",
    "Gedit",
    "Gsplit",
    "Gread",
    "Gwrite",
    "Ggrep",
    "GMove",
    "GRename",
    "GDelete",
    "GRemove",
    "GBrowse",
    "Git",
    "Gstatus",
  },
  init = function() vim.g.fugitive_no_maps = 1 end,
}

return M
