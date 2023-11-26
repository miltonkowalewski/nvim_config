local M = {}

M.lazy =
  -- https://github.com/nvimdev/guard.nvim
  {
    "nvimdev/guard.nvim",
    event = "VeryLazy",
    -- Builtin configuration, optional
    dependencies = {
      "nvimdev/guard-collection",
    },
    config = function()
      local ft = require("guard.filetype")

      -- Lint and format on save lua
      -- https://github.com/sumneko/lua-language-server
      ft("lua"):fmt("stylua"):lint("selene")
      -- Lint and format on save python
      -- https://github.com/astral-sh/ruff
      -- https://github.com/psf/black
      ft("python"):fmt("black"):lint("ruff")

      -- Call setup() LAST!
      require("guard").setup({
        -- the only options for the setup function
        fmt_on_save = true,
        -- Use lsp if no formatter was defined for this filetype
        lsp_as_default_formatter = false,
      })
    end,
    keys = {
      { "<leader>lf", mode = { "n", "v" }, function() require("guard").format() end, desc = "Guard Format" },
    },
  }

return M
