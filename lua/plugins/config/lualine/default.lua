local has_lualine_require, _ = pcall(require, "lualine_require")
if not has_lualine_require then return end

local icons = require("config.icons")

vim.o.laststatus = vim.g.lualine_laststatus

require("lualine").setup({
  options = {
    theme = "auto",
    globalstatus = true,
    disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = {
      {
        "diagnostics",
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      },
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      { 'filename', path = 1 },
    {
      'aerial',
      sep = " ", -- separator between symbols
      sep_icon = "", -- separator between icon and symbol
      depth = 5,
      dense = false,
      dense_sep = ".",
      colored = true,
    },
    },
    lualine_x = {
      {
        function() return require("noice").api.status.command.get() end,
        cond = function()
          local has_noice, noice = pcall(require, "noice")
          if has_noice then
            if noice.api.status.command.has() then return true end
          end
          return false
        end,
        color = require("core.lua_tools").fg("Statement"),
      },
      {
        function() return require("noice").api.status.mode.get() end,
        cond = function()
          local has_noice, noice = pcall(require, "noice")
          if has_noice then
            if noice.api.status.mode.has() then return true end
          end
          return false
        end,
        color = require("core.lua_tools").fg("Constant"),
      },
      {
        function() return "  " .. require("dap").status() end,
        cond = function()
          local has_dap, dap = pcall(require, "dap")
          if has_dap then
            if dap.status() ~= "" then return true end
          end
          return false
        end,
        color = require("core.lua_tools").fg("Debug"),
      },
      -- {
      --   require("lazy.status").updates,
      --   cond = require("lazy.status").has_updates,
      --   color = require("core.lua_tools").fg("Special"),
      -- },
      {
        "diff",
        symbols = {
          added = icons.git.added,
          modified = icons.git.modified,
          removed = icons.git.removed,
        },
        source = function()
          local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
            return {
              added = gitsigns.added,
              modified = gitsigns.changed,
              removed = gitsigns.removed,
            }
          end
        end,
      },
    },
    lualine_y = {
      { "progress", separator = " ", padding = { left = 1, right = 0 } },
      { "location", padding = { left = 0, right = 1 } },
    },
    lualine_z = {
      function() return " " .. os.date("%R") end,
    },
  },
  extensions = { "neo-tree", "aerial", "mason", "lazy" },
})
