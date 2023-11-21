local M = {}
local serverconfig = {}

local function lsp_appearance_load()
  local signs = {
    -- change the "?" to an icon that you like
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "󰌶" },
    { name = "DiagnosticSignInfo", text = "" },
  }
  local config = {
    virtual_text = false,
    signs = {
      active = signs,
    },
    update_in_insert = false,
    underline = true,
    -- float = {border = "rounded"},
    severity_sort = false,
  }

  vim.diagnostic.config(config)
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end
end

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

local function pyright_setup ()
  local util = require('lspconfig/util')

  local project_root = util.find_git_ancestor(vim.fn.getcwd()) or vim.fn.getcwd()

  require('lspconfig').pyright.setup({
    before_init = function(_, config)
      config.settings.python.pythonPath = get_python_path(config.root_dir)
    end,
    on_attach = serverconfig.on_attach,
    capabilities = serverconfig.capabilities,
    on_new_config = function(new_config, new_root_dir)
      new_config.cmd_cwd = new_root_dir
    end,
    filetypes = { 'python' },
    root_dir = function(fname)
      return util.root_pattern(
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        '.git',
        'Makefile'
      )(fname) or project_root
    end,
  })
end

local function ruff_lsp()
  local util = require('lspconfig/util')
  local project_root = util.find_git_ancestor(vim.fn.getcwd()) or vim.fn.getcwd()

  require'lspconfig'.ruff_lsp.setup{
    init_options = {
      settings = {
        -- Any extra CLI arguments for `ruff` go here.
        args = {},
      }
    },
    on_attach = function (client)
      client.server_capabilities.hoverProvider = false
    end,
    capabilities = serverconfig.capabilities,
    filetypes = { 'python' },
    single_file_support = true,
    root_dir = function(fname)
      return util.root_pattern(
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        '.git',
        'Makefile'
      )(fname) or project_root
    end,
  }
end


local function lua_ls_setup ()
  require('lspconfig').lua_ls.setup {
    on_attach = serverconfig.on_attach,
    capabilities = serverconfig.capabilities,

    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
            [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },

    servers = {
      jsonls = {
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
          end,
        settings = {
          json = {
            format = {
              enable = true,
            },
            validate = { enable = true },
          }
        }
      },
    }
  }
end

M.lazy = {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    lsp_appearance_load()

    serverconfig.on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end

    serverconfig.capabilities = vim.lsp.protocol.make_client_capabilities()
    local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if has_cmp_nvim_lsp then
      serverconfig.capabilities = cmp_nvim_lsp.default_capabilities(serverconfig.capabilities)
    end
    serverconfig.capabilities.textDocument.completion.completionItem = {
      documentationFormat = { "markdown", "plaintext" },
      snippetSupport = true,
      preselectSupport = true,
      insertReplaceSupport = true,
      labelDetailsSupport = true,
      deprecatedSupport = true,
      commitCharactersSupport = true,
      tagSupport = { valueSet = { 1 } },
      resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      },
    }

    -- [[ Use command bellow to inspect running server setup ]]
    -- :lua print(vim.inspect(vim.lsp.get_active_clients()))
    -- [[ add Mason installed server setup here like pyright and lua_ls, I prefer not automatic setup ]]
    lua_ls_setup()
    pyright_setup()
    -- ruff_lsp()
  end,
  keys = {
    { "gd", mode = {"n"}, vim.lsp.buf.definition, desc="Lsp Goto Definition" },
    { "gX", mode = {"n"}, ":rightbelow split | lua vim.lsp.buf.definition()<CR>", desc="Lsp Horizontal Split Goto Definition" },
    { "gV", mode = {"n"}, ":rightbelow vsplit | lua vim.lsp.buf.definition()<CR>", desc="Lsp Vertical Split Goto Definition" },
    { "K", mode = {"n"}, vim.lsp.buf.hover, desc="Lsp Hover" },
    { "<leader>lr", mode = {"n"}, vim.lsp.buf.rename, desc="Lsp Rename" },
    { "<leader>lf", mode = {"n", "v"}, function() vim.lsp.buf.format { async = true } end, desc="Lsp Format" },
    -- diagnostics
    { "dK", mode = {"n"}, function() vim.diagnostic.open_float() end, desc="Lsp Diagnostic Float" },
    { "dn", mode = {"n"}, function() vim.diagnostic.goto_next() end, desc="Lsp Diagnostic Goto Next" },
    { "dN", mode = {"n"}, function() vim.diagnostic.goto_prev() end, desc="Lsp Diagnostic Goto Prev" },
  }
}

return M
