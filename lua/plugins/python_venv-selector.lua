local M = {}

M.lazy =
{
    "linux-cultist/venv-selector.nvim",
    ft = "python",
    cmd = "VenvSelect",
    init = function()
      vim.g.venv_selector_use_location_list = 1
    end,
    opts = function(_, opts)
      if require("lazyvim.util").has("nvim-dap-python") then
        opts.dap_enabled = true
      end
      return vim.tbl_deep_extend("force", opts, {
        name = {
          "venv",
          ".venv",
          "env",
          ".env",
        },
      })
    end,
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
  }

return M
