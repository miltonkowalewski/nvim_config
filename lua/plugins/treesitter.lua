local M = {}

M.lazy = {
  "nvim-treesitter/nvim-treesitter",
  init = function() require("core.utils").lazy_load "nvim-treesitter" end,
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "lua", "python", "json", "bash", "yaml", "sql", "regex", "markdown", "markdown_inline" },
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
