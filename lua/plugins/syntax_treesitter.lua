local M = {}

M.lazy = {
  "nvim-treesitter/nvim-treesitter",
  init = function() require("core.utils").lazy_load "nvim-treesitter" end,
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "bash",
      "json",
      "json5",
      "jsonc",
      "lua",
      "dockerfile",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "php",
      "regex",
      "sql",
      "yaml",
    },
    highlight = {
      enable = true,
      use_languagetree = true,
      disable = function(_, bufnr) return vim.b[bufnr].large_buf end,
    },
    indent = { enable = true },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}

return M
