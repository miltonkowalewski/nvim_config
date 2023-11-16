local M = {}

M.lazy =
-- https://github.com/rcarriga/nvim-dap-ui
{
  "rcarriga/nvim-dap-ui",
  dependencies = { 'mfussenegger/nvim-dap' },
  opts = {
      controls = {
        element = "repl",
        enabled = true,
        icons = {
          disconnect = "",
          pause = "",
          play = "",
          run_last = "",
          step_back = "",
          step_into = "",
          step_out = "",
          step_over = "",
          terminate = ""
        }
      },
      element_mappings = {},
      expand_lines = true,
      floating = {
        border = "rounded",
        mappings = {
          close = { "q", "<Esc>" }
        }
      },
      force_buffers = true,
      icons = {
        collapsed = "",
        current_frame = "",
        expanded = ""
      },
      layouts = { {
        elements = { {
          id = "scopes",
          size = 0.5
        }, {
            id = "breakpoints",
            size = 0.125
          }, {
            id = "stacks",
            size = 0.125
          },
        {
          id = "console",
          size = 0.25
        }
      },
        position = "left",
        size = 40
      }, {
          elements = {
          {
            id = "watches",
            size = 0.5
          },
          {
            id = "repl",
            size = 0.5
          },
        },
          position = "bottom",
          size = 10
        } },
      mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t"
      },
      render = {
        indent = 1,
        max_value_lines = 100
      }
    },
  config = function(_, opts)
    local dap, dapui = require "dap", require "dapui"
    -- open automatically
    dap.listeners.after.event_initialized["dapui_config"] = function()
      -- dapui.open()
      dapui.open({ layout = 2 })
    end
    -- close automatically
    dap.listeners.before.event_terminated["dapui_config"] = function()
      -- dapui.close()
    end
    -- close automatically
    dap.listeners.before.event_exited["dapui_config"] = function()
      -- dapui.close()
    end
    dapui.setup(opts)
  end,
  keys = {
    -- only into buffer
    { "<leader>de", mode = { "n" }, function()
      vim.ui.input({ prompt = "Expression: " }, function(expr)
        if expr then require("dapui").eval(expr, { enter = true }) end
      end)
    end, desc = "Debugger Evaluate Input Expression" },
    { "<leader>dK", mode = { "n", "x" }, function()
      require("dapui").eval()
      require("dapui").eval() -- the socond time is to jump into eval inpector
    end, desc = "Debugger Evaluate Input" },
    { "<leader>dw", mode = { "n", "x" }, function() require("dapui").repl(vim.fn.expand("<cword>")) end, desc = "Debugger Watch Expression" },
    { "<leader>dh", mode = { "n" }, function() require("dapui").eval() end, desc = "Debugger Hover" },
    -- toogle ui elements
    { "<leader>du", mode = { "n" }, function() require("dapui").toggle() end, desc = "Debugger UI" },
    { "<leader>dv", mode = { "n" }, function() require("dapui").toggle({ layout = 1 }) end, desc = "Debugger UI Side Panel" },
    { "<leader>db", mode = { "n" }, function() require("dapui").toggle({ layout = 2 }) end, desc = "Debugger UI Bottom Panel" },
  }
}

return M
