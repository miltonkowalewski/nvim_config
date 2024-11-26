return {
  'VonHeikemen/lsp-zero.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  cmd = 'Mason',
  branch = 'v4.x',
  dependencies = {
    { 'neovim/nvim-lspconfig' },
    {
      'williamboman/mason.nvim',
      build = function()
        pcall(vim.cmd, 'MasonUpdate')
      end
    },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'williamboman/mason-lspconfig.nvim', },
    { "WhoIsSethDaniel/mason-tool-installer.nvim", },
    { 'L3MON4D3/LuaSnip' },
    { 'SmiteshP/nvim-navic' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'rafamadriz/friendly-snippets' },
    -- { "hinell/lsp-timeout.nvim", },
    {
      "Exafunction/codeium.nvim",
      dependencies = {
        { "nvim-lua/plenary.nvim" },
        { 'hrsh7th/nvim-cmp' },
      },
      cmd = "Codeium",
      opts = {},
    },
    -- {
    --   "ray-x/lsp_signature.nvim",
    --   event = "VeryLazy",
    --   opts = {
    --     bind = true,
    --     wrap = true,
    --     floating_window = false,
    --     -- border = "rouded",
    --     hint_enable = true,
    --     hint_prefix = {
    --         above = "↙ ",  -- when the hint is on the line above the current line
    --         current = "← ",  -- when the hint is on the same line
    --         below = "↖ "  -- when the hint is on the line below the current line
    --     }
    --   },
    -- },
  },
  config = function()
    local _border = {
      border = "single",
    }

    vim.diagnostic.config({
      float = _border,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '✘',
          [vim.diagnostic.severity.WARN] = '▲',
          [vim.diagnostic.severity.HINT] = '⚑',
          [vim.diagnostic.severity.INFO] = '',
        },
      },
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, _border
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, _border
    )

    require('lspconfig.ui.windows').default_options = _border

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = event.buf, desc = "Show hover" })
        vim.keymap.set('n', 'gK', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gX', '<cmd>rightbelow split | lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gV', '<cmd>rightbelow vsplit | lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<leader>F', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', 'gA', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
      end,
    })

    local lspconfig_defaults = require('lspconfig').util.default_config
    lspconfig_defaults.capabilities = vim.tbl_deep_extend(
      'force',
      lspconfig_defaults.capabilities,
      require('cmp_nvim_lsp').default_capabilities()
    )

    require('mason').setup({})
    require('mason-lspconfig').setup({
      ensure_installed = {
        "cssls",
        "eslint",
        "html",
        "jsonls",
        "pyright",
        "tailwindcss",
        "ruff",
        "lua_ls",
        "marksman",
        "dockerls",
        "bashls",
      },
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup({})
        end,
      }
    })

    local has_codeium, _ = pcall(require, "lspconfig.ruff")
    if not has_codeium then
      vim.notify("Ruff was installed", "info", { title = "Ruff" })
    end

    require("lspconfig").ruff_lsp.setup({
      on_attach = lspconfig_defaults.on_attach,
    })

    -- Pyright
    -- require("lspconfig").pyright.setup {
    --   on_attach = lspconfig_defaults.on_attach,
    --   cmd = { "pyright-langserver", "--stdio" },
    --   filetypes = { "python" },
    --   settings = {
    --     python = {
    --       pyright = {
    --         autoImportCompletion = true,
    --       },
    --       analysis = {
    --         autoSearchPaths = true,
    --         useLibraryCodeForTypes = true,
    --         diagnosticMode = 'openFilesOnly',
    --       }
    --     }
    --   }
    -- }

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

    local lsp_zero = require('lsp-zero')

    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettier",
        "stylua", -- lua formatter
        "isort",  -- python formatter
        "black",  -- python formatter
        "pylint",
        "eslint_d",
      },
    })

    local cmp = require('cmp')
    local defaults = require("cmp.config.default")()
    local cmp_action = lsp_zero.cmp_action()
    -- local cmp_action = require('lsp-zero').cmp_action()

    require('luasnip.loaders.from_vscode').lazy_load()

    local opts = {
      preselect = 'none', -- Disable automatic selection
      completeopt = 'menu,menuone,noinsert',
      sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'luasnip', keyword_length = 2 },
      },
      {
        { name = 'buffer', keyword_length = 3 },
      },
      mapping = {
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<Down>'] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,
        ['<Up>'] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
      },
      -- window = {
      --   completion = cmp.config.window.bordered(),
      --   documentation = cmp.config.window.bordered(),
      -- },
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end
      },
      formatting = {
        format = function(_, item)
          local icons = require("config.icons").kinds
          if icons[item.kind] then item.kind = icons[item.kind] .. item.kind end
          return item
        end,
      },
      -- experimental = {
      --   ghost_text = {
      --     hl_group = "CmpGhostText",
      --   },
      -- },
      sorting = defaults.sorting,
    }

    local has_codeium, _ = pcall(require, "codeium")
    if has_codeium then
      vim.notify("Codeium was running", "info", { title = "Codeium" })
      table.insert(opts.sources, 1, {
        name = "codeium",
      })
    end

    cmp.setup(opts)
  end
}
