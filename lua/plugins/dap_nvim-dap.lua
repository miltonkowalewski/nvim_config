local M = {}

local function dap_config_parse(config)
  local configs = {}
  if config then
    for _, conf in ipairs(config.configurations) do
      table.insert(configs, conf)
    end
  end
  return configs
end

local function load_dap_config(config_file_name)
  -- Read the JSON file
  local file = io.open(config_file_name, "r")
  if not file then return {} end

  local json_text = file:read("*all")
  file:close()

  local has_dkjson, dkjson = pcall(require, "dkjson")
  if has_dkjson then
    -- Parse the JSON into a Lua table
    local config = dkjson.decode(json_text)
    return dap_config_parse(config)
  end

  local has_cjson, cjson = pcall(require, "cjson")
  if has_cjson then
    -- Parse the JSON into a Lua table
    local config = cjson.decode(json_text)
    return dap_config_parse(config)
  end

  local has_lua2json, lua2json = pcall(require, "lua2json")
  if has_lua2json then
    -- Parse the JSON into a Lua table
    local config = lua2json.decode(json_text)
    return dap_config_parse(config)
  end

  print("cjson, dkjson or lua2json not found to parse dap config in " .. config_file_name)
  return dap_config_parse()
end

M.lazy =
  --  DEBUGGER ----------------------------------------------------------------
  --  Debugger alternative to vim-inspector [debugger]
  --  https://github.com/mfussenegger/nvim-dap
  --  Here we configure the adapter+config of every debugger.
  --  Debuggers don't have system dependencies, you just install them with mason.
  --  We currently ship most of them with nvim.
  {
    "mfussenegger/nvim-dap",
    event = "User BaseFile",
    config = function(_, opts)
      local dap = require("dap")
      local cwd = vim.fn.getcwd()
      local configs = {}
      -- Load dap config in .nvim folder
      local dap_nvim_config = load_dap_config(cwd .. "/.nvim/launch.json")
      for _, conf in ipairs(dap_nvim_config) do
        table.insert(configs, conf)
      end
      -- Load dap config in .vscode folder
      local dap_vscode_config = load_dap_config(cwd .. "/.vscode/launch.json")
      for _, conf in ipairs(dap_vscode_config) do
        table.insert(configs, conf)
      end
      -- Try load local env first or use global if a pythonPath is not informed
      for _, conf in ipairs(configs) do
        if not conf["pythonPath"] then
          conf.pythonPath = function()
            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
              return cwd .. "/venv/bin/python"
            elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
              return cwd .. "/.venv/bin/python"
            else
              return "/usr/bin/python"
            end
          end
        end
      end
      -- Python
      dap.adapters.python = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
        args = { "-m", "debugpy.adapter" },
      }
      dap.configurations.python = configs
    end, -- of dap config
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        "jbyuki/one-small-step-for-vimkind",
        "https://github.com/mfussenegger/nvim-jdtls",
        dependencies = { "mfussenegger/nvim-dap" },
        cmd = { "DapInstall", "DapUninstall" },
        opts = { handlers = {} },
      },
      {
        "rcarriga/cmp-dap",
        dependencies = { "nvim-cmp" },
      },
      {
        "Weissle/persistent-breakpoints.nvim",
        config = function()
          require("persistent-breakpoints").setup({
            load_breakpoints_event = { "BufReadPost" },
          })
        end,
        keys = {
          { "<F12>", mode = { "n", "x" }, "<cmd>PBToggleBreakpoint<cr>", desc = "Debugger Toggle Breakpoint" },
        },
      },
    },
    keys = {
      { "<F5>", mode = { "n", "x" }, function() require("dap").terminate() end, desc = "Debugger Stop" },
      { "<F6>", mode = { "n", "x" }, function() require("dap").step_back() end, desc = "Debugger Step Back" },
      { "<F7>", mode = { "n", "x" }, function() require("dap").continue() end, desc = "Debugger Start/Continue" },
      { "<F19>p", mode = { "n", "x" }, function() require("dap").pause() end, desc = "Debugger Pause" },
      { "<F8>", mode = { "n", "x" }, function() require("dap").step_over() end, desc = "Debugger Step Over" },
      { "<F20>c", mode = { "n", "x" }, function() require("dap").run_to_cursor() end, desc = "Debugger Run to Cursor" },
      { "<F20>i", mode = { "n", "x" }, function() require("dap").step_into() end, desc = "Debugger Step Into" },
      { "<F20>x", mode = { "n", "x" }, function() require("dap").step_out() end, desc = "Debugger Step Out" },
      { "<F9>r", mode = { "n", "x" }, function() require("dap").restart_frame() end, desc = "Debugger Restart" },
      {
        "<F11>",
        mode = { "n", "x" },
        function() require("dap").clear_breakpoints() end,
        desc = "Debugger Clear Breakpoint",
      },
      {
        "<F24>c",
        mode = { "n", "x" },
        function()
          vim.ui.input({ prompt = "Condition: " }, function(condition)
            if condition then require("dap").set_breakpoint(condition) end
          end)
        end,
        desc = "Debugger Breakpoint Condition",
      },
      {
        "<F24>l",
        mode = { "n", "x" },
        function()
          vim.ui.input({ prompt = "Message: " }, function(condition)
            if condition then require("dap").set_breakpoint(nil, nil, condition) end
          end)
        end,
        desc = "Debugger Log Point Message",
      },
      -- widgets
      {
        "<leader>ds",
        mode = { "n", "x" },
        function()
          local widgets = require("dap.ui.widgets")
          require("dap.ui.widgets").sidebar(widgets.scopes).open()
        end,
        desc = "Debugger Toggle Scope View (Only)",
      },
    },
  }

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  -- group = "BufReadPre",
  desc = "prevent colorscheme clears self-defined DAP icon colors.",
  callback = function()
    vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#df2020" })
    vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#63e9e9" })
    vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#00ff3c" })
  end,
})

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointCondition", { text = "󰯲", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapLogPoint", { text = "󱂅 ", texthl = "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped" })

return M
