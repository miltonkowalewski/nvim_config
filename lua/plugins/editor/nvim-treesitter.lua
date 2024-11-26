return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "nvim-tree/nvim-web-devicons",
    },
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = {
            "vim",
            "regex",
            "bash",
            "json",
            "javascript",
            "typescript",
            "tsx",
            "html",
            "css",
            "gitignore",
            "c",
            "rust",
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
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end
 }
