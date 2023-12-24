local config_mason = require("plugins.config.plugin-manager.mason_config")
return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "neovim/nvim-lspconfig"
    },
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "black",
        "debugpy",
        "mypy",
        "ruff",
        "ruff-lsp",
        "pyright",
        "markdownlint",
        "marksman",
        "cmakelang",
        "cmakelint",
        "hadolint",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "bash-language-server"
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      config_mason.registry(opts.ensure_installed)
    end,
  },
}
