local serverconfig = {}

local function lsp_appearance_load()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "󰌶" },
    { name = "DiagnosticSignInfo", text = "" },
  }
  local diagnostics = {
    virtual_text = {
      spacing = 4,
      -- source = "if_many",
      prefix = "●",
      -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
      -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
      -- prefix = "icons",
    },
    float = {
      source = "always", -- Or "if_many"
    },
    signs = {
      active = signs,
    },
    update_in_insert = false,
    underline = true,
    -- float = {border = "rounded"},
    severity_sort = true,
  }

  vim.diagnostic.config(diagnostics)
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end
end

local function get_python_path(workspace)
  local util = require("lspconfig/util")
  local path = util.path
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then return path.join(vim.env.VIRTUAL_ENV, "bin", "python") end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({ "*", ".*" }) do
    local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
    if match ~= "" then return path.join(path.dirname(match), "bin", "python") end
  end

  -- Fallback to system Python.
  return "python"
end

local function pyright_setup()
  local util = require("lspconfig/util")
  local project_root = util.find_git_ancestor(vim.fn.getcwd()) or vim.fn.getcwd()

  require("lspconfig").pyright.setup({
    -- https://microsoft.github.io/pyright/#/settings?id=pyright-settings
    before_init = function(_, config) config.settings.python.pythonPath = get_python_path(config.root_dir) end,
    settings = {
      python = {
        disableOrganizeImports = true,
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "openFilesOnly",
          typeCheckingMode = "off",
          useLibraryCodeForTypes = true,
        },
      },
    },
    on_attach = serverconfig.on_attach,
    capabilities = serverconfig.capabilities,
    on_new_config = function(new_config, new_root_dir) new_config.cmd_cwd = new_root_dir end,
    filetypes = { "python" },
    root_dir = function(fname)
      return util.root_pattern("pyproject.toml", "setup.py", "setup.cfg", ".git", "Makefile")(fname) or project_root
    end,
  })
end

local function ruff_lsp()
  local util = require("lspconfig/util")
  local project_root = util.find_git_ancestor(vim.fn.getcwd()) or vim.fn.getcwd()

  require("lspconfig").ruff_lsp.setup({
    -- https://github.com/astral-sh/ruff-lsp#example-neovim
    init_options = {
      settings = {
        -- Any extra CLI arguments for `ruff` go here.
        args = {},
      },
    },
    on_attach = serverconfig.on_attach,
    capabilities = serverconfig.capabilities,
    filetypes = { "python" },
    single_file_support = true,
    root_dir = function(fname)
      return util.root_pattern("pyproject.toml", "setup.py", "setup.cfg", ".git", "Makefile")(fname) or project_root
    end,
  })
end

local function lua_ls_setup()
  require("lspconfig").lua_ls.setup({
    on_attach = serverconfig.on_attach,
    capabilities = serverconfig.capabilities,

    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },

    servers = {
      jsonls = {
        on_new_config = function(new_config) new_config.settings.json.schemas = new_config.settings.json.schemas or {} end,
        settings = {
          json = {
            format = {
              enable = true,
            },
            validate = { enable = true },
          },
        },
      },
    },
  })
end

return
{
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "LspInfo", "LspInstall", "LspUninstall" },
  dependencies = {
    "hrsh7th/nvim-cmp",
    "nvim-lua/plenary.nvim",
    -- {
    --   "ray-x/lsp_signature.nvim",
    --   event = "VeryLazy",
    --   opts = {
    --     border = "rouded",
    --     hint_prefix = "👉 ",
    --   },
    --   config = function(_, opts) require'lsp_signature'.setup(opts) end
    -- },
  },
  config = function()
    serverconfig.capabilities = vim.lsp.protocol.make_client_capabilities()
    serverconfig.on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end
    lsp_appearance_load()
    -- [[ Use command bellow to inspect running server setup ]]
    -- :lua print(vim.inspect(vim.lsp.get_active_clients()))
    require("lspconfig").pyright.setup({
      on_attach = serverconfig.on_attach,
      settings = {
        pyright = {
          autoImportCompletion = true,
        },
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = 'openFilesOnly',
            useLibraryCodeForTypes = true,
            typeCheckingMode = 'off'
          }
        }
      }
    })
    require('lspconfig').yamlls.setup({})
    require('lspconfig').dockerls.setup({})
    require('lspconfig').docker_compose_language_service.setup({})
    require("lspconfig").ruff_lsp.setup({
      on_attach = serverconfig.on_attach,
    })
    require("lspconfig").lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
        },
      },
    })
    require('lspconfig').bashls.setup({})

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to declaration" })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = "Show hover" })
        vim.keymap.set('n', 'dK', vim.diagnostic.open_float, { buffer = ev.buf, desc = "Show diagnostic" })
        vim.keymap.set('n', 'gX', ":rightbelow split | lua vim.lsp.buf.definition()<CR>",
          { buffer = ev.buf, desc = "Open LSP definition in new split" })
        vim.keymap.set('n', "gV", ":rightbelow vsplit | lua vim.lsp.buf.definition()<CR>",
          { buffer = ev.buf, desc = "Open LSP definition in new vertical split" })
        --vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = ev.buf })
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Show signature help" })
        --vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = ev.buf })
        --vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf })
        --vim.keymap.set('n', '<leader>wl', function()
        --  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        --end, { buffer = ev.buf })
        vim.keymap.set('n', '<leader>ld', vim.lsp.buf.type_definition,
          { buffer = ev.buf, desc = "Show type definition" })
        vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename symbol" })
        vim.keymap.set({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action,
          { buffer = ev.buf, desc = "Show code actions" })
        vim.keymap.set('n', 'lr', vim.lsp.buf.references, { buffer = ev.buf, desc = "Show references" })
        vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end,
          { buffer = ev.buf, desc = "Format document" })
      end,
    })
  end,
}
