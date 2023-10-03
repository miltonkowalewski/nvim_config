local M = {}

local wk_register = {
  -- which_key registers
  telescope = {
    ["<leader>f"] = { name = "Find" },
    ["<leader><tab>"] = { name = "Nvim Tab" },
    ["<leader>c"] = { name = "Config Shortcut" },
    ["<leader>b"] = { name = "Buffer" },
    ["<leader>d"] = { name = "Diagnostics" },
    ["<leader>l"] = { name = "Lsp actions" },
    ["<leader>t"] = { name = "Test" },
    ["<leader>w"] = { name = "Nvim Windows" },
    ["<leader>g"] = { name = "Git" },
    ["<leader>z"] = { name = "Zen Mode" },
    ["<leader>0"] = { name = "*" },
    ["<leader>q"] = { name = "Quickfix list" },
      ["<leader>0d"] = { name = "Dooku (Doc Gen)" },
      ["<leader>0m"] = { name = "Markdown" },
      ["<leader>0s"] = { name = "Sessions (Session State Manager)" },
      ["<leader>0o"] = { name = "Overseer (Task Runner)" },
      ["<leader>0h"] = { name = "Hardtime (Nvim best practices)" },
    ["gp"] = { name = "gPreview" },
  }
}

M.lazy = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  keys = { "<leader>", '"', "'", "`", "c", "v", "g" },

  opts = {
    disable = {
      filetypes = { "TelescopePrompt" } ,
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "»", -- symbol used between a key and it's label
      group = "", -- symbol prepended to a group
    },
    window = {
      position = "bottom",
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(wk_register.telescope)
  end,
}

return M
