return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    config = function()
      themes = {
        "plugins.config.lualine.default",
        "plugins.config.lualine.eviline",
        "plugins.config.lualine.bubbles",
        "plugins.config.lualine.slanted",
      }
      require(require("core.lua_tools").getRandomValue(themes))
    end
  },
}
