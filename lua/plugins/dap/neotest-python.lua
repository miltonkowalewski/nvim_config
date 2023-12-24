local function get_python_path(workspace)
  local util = require('lspconfig/util')
  local path = util.path
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({'*', '.*'}) do
    local match = vim.fn.glob(path.join(workspace, pattern, 'pyvenv.cfg'))
    if match ~= '' then
      return path.join(path.dirname(match), 'bin', 'python')
    end
  end

  -- Fallback to system Python.
  return 'python'
end

local function pytest_adapter_setup()
  return {
    -- extra arguments for nvim-dap configuration
    -- see https://github.com/microsoft/debugpy/wiki/debug-configuration-settings for values
    python = get_python_path("${workspaceFolder}/.venv/bin/python"),
    dap = {
      justmycode = true,
      -- console = "integratedterminal",
    },
    runner = "pytest",
  }
end

local function unittest_adapter_setup()
  return {
    -- extra arguments for nvim-dap configuration
    -- see https://github.com/microsoft/debugpy/wiki/debug-configuration-settings for values
    python = get_python_path("${workspaceFolder}/.venv/bin/python"),
    dap = {
      justmycode = true,
      -- console = "integratedterminal",
    },
    runner = "pytest",
  }
end

local neotest_python_opts = function()
  return {
    adapters = {
      require("neotest-python")(
        -- pytest_adapter_setup()
        unittest_adapter_setup()
      ),
    },
  }
end

return {
  "nvim-neotest/neotest-python",
  dependencies = {
    "nvim-neotest/neotest",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
  },
  ft = "python",
  opts = neotest_python_opts,
  config = function(_, opts) require("neotest").setup(opts) end,
  keys = {
    { "<leader>tF", mode = { "n" }, function()
      require('neotest').run.run({strategy = 'dap'})
      local has_dap_ui, dapui = pcall(require, "dapui")
      if has_dap_ui then
        dapui.open({ layout = 2 })
      end
    end, desc = "Debug Test Function DAP" },
    { "<leader>tC", mode = { "n" }, function() require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'}) end, desc = "Debug Test Class DAP" },
    { "<leader>tf", mode = { "n" }, function() require('neotest').run.run() end, desc = "Test Function" },
    { "<leader>tc", mode = { "n" }, function() require('neotest').run.run({vim.fn.expand('%')}) end, desc = "Test Class" },
    { "<leader>tt", mode = { "n" }, function() require('neotest').summary.toggle() end, desc = "Test Summary Toggle" },
    { "<leader>ts", mode = { "n" }, function() require("neotest").run.stop() end, desc = "Test Stop" },
  },
}
