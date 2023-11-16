local M = {}

local mason_opts = function()
  return {
    ensure_installed = {
      "lua-language-server",
      "black",
      "debugpy",
      "mypy",
      "ruff-lsp",
      "pyright",
      "markdownlint",
      "marksman",
    },

    PATH = "prepend",

    ui = {
      -- border = "rounded",
      icons = {
        package_pending = " ",
        package_installed = "",
        package_uninstalled = "",
      },

      keymaps = {
        toggle_server_expand = "<CR>",
        install_server = "i",
        update_server = "u",
        check_server_version = "c",
        update_all_servers = "U",
        check_outdated_servers = "C",
        uninstall_server = "X",
        cancel_installation = "<C-c>",
      },
    },
    -- log_level = vim.log.levels.INFO,
    max_concurrent_installers = 10,
    automatic_installation = true,
  }
end

M.lazy = {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
  opts = mason_opts,
  config = function(_, opts)
    require("mason").setup(opts)
  end,
}

return M
