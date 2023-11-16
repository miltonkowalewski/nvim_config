local M = {}

local mason_lspconfig_opts = function()
  return {
    ensure_installed = { "lua_ls", "ruff_lsp", "pyright" },
  }
end

M.lazy = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
  opts = mason_lspconfig_opts,
  config = function(_, opts)
    require("mason-lspconfig").setup(opts)
  end,
}

return M
