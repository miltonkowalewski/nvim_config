local M = {}

local cmp_config = function(_)
  local cmp = require("cmp")
  local defaults = require("cmp.config.default")()
  -- dap config
  local dap_source = {}
  local dap_filetype = {}
  local has_dap, _ = pcall(require, "dap")
  if has_dap then
    dap_filetype = { "dap-repl", "dapui_watches", "dapui_hover" }
    dap_source = { "dap" }
  end

  local formatting_style = {
    -- default fields order i.e completion word + item.kind + item.kind icons
    fields = { "abbr", "kind", "menu" },
  }

  -- local function border(hl_name)
  --   return {
  --     { "╭", hl_name },
  --     { "─", hl_name },
  --     { "╮", hl_name },
  --     { "│", hl_name },
  --     { "╯", hl_name },
  --     { "─", hl_name },
  --     { "╰", hl_name },
  --     { "│", hl_name },
  --   }
  -- end
  -- local function border(hl_name)
  --   return {
  --     { "┌", hl_name },
  --     { "─", hl_name },
  --     { "┐", hl_name },
  --     { "│", hl_name },
  --     { "┘", hl_name },
  --     { "─", hl_name },
  --     { "└", hl_name },
  --     { "│", hl_name },
  --   }
  -- end
  -- local function border(hl_name)
  --   return {
  --     { "┏", hl_name },
  --     { "━", hl_name },
  --     { "┓", hl_name },
  --     { "┃", hl_name },
  --     { "┛", hl_name },
  --     { "━", hl_name },
  --     { "┗", hl_name },
  --     { "┃", hl_name },
  --   }
  -- end
  -- local function border(hl_name)
  --   return {
  --     { "╔", hl_name },
  --     { "═", hl_name },
  --     { "╗", hl_name },
  --     { "║", hl_name },
  --     { "╝", hl_name },
  --     { "═", hl_name },
  --     { "╚", hl_name },
  --     { "║", hl_name },
  --   }
  -- end
  local function border(hl_name)
    -- 󰕛 󰢛      󰕛 󰪏 󰟍  󰵅 󰁨 󰉂 󰓬 󱃷 󰒻 󰊾 󱠁  󰝧 󰅽 󰖵 󱨟 󱉱  󰬢 󱃖 a
    --  󰧑 󰂾    󰦷 󱐋 󰗣    󰠠 󱊒 󰖦  󰃉 󱤌    󰜮 󰜱 󰜴 󰜷 󰗚 󰒔 󰴜 a
    --  󰭩  󰥙 󱃘  󰣖   󰅏  󱘖 a
    return {
      { "󱘖", hl_name },
      { "─", hl_name },
      { "╮", hl_name },
      { " ", hl_name },
      { "", hl_name },
      -- { "┛", hl_name },
      { "─", hl_name },
      { "╰", hl_name },
      { " ", hl_name },
    }
  end

  cmp.setup({
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
    window = {
      completion = {
        side_padding = 0,
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        scrollbar = true,
        border = border "CmpBorder"
      },
      documentation = {
        border = border "CmpDocBorder",
        winhighlight = "Normal:NormalFloat",
      },
    },
    snippet = {
      expand = function(args)
        -- require("luasnip").lsp_expand(args.body)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    preselect = cmp.PreselectMode.None,
    formatting = formatting_style,
    duplicates = {
      nvim_lsp = 1,
      luasnip = 1,
      cmp_tabnine = 1,
      buffer = 1,
      path = 1,
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<Up>"] = cmp.mapping.select_prev_item(),
      ["<Down>"] = cmp.mapping.select_next_item(),
      ["<C-u>"] = cmp.mapping.scroll_docs(-4),
      ["<C-d>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-c>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif require("luasnip").expand_or_jumpable() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif require("luasnip").jumpable(-1) then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    filetype = dap_filetype,
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "nvim_lua" },
      { name = "path" },
      dap_source,
    }, {
      { name = "buffer" },
    }),
    sorting = defaults.sorting,
  })
end

local luasnip_config = function(opts)
  require("luasnip").config.set_config(opts)

  -- vscode format
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }

  -- snipmate format
  require("luasnip.loaders.from_snipmate").load()
  require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }

  -- lua format
  require("luasnip.loaders.from_lua").load()
  require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }

  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      if
        require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require("luasnip").session.jump_active
      then
        require("luasnip").unlink_current()
      end
    end,
  })
end

M.lazy = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    {
      -- snippet plugin
      "L3MON4D3/LuaSnip",
      dependencies = "rafamadriz/friendly-snippets",
      opts = { history = true, updateevents = "TextChanged,TextChangedI" },
      config = function(_, opts)
        luasnip_config(opts)
      end,
    },
    -- autopairing of (){}[] etc
    {
      "windwp/nvim-autopairs",
      opts = {
        fast_wrap = {},
        disable_filetype = { "TelescopePrompt", "vim" },
      },
      config = function(_, opts)
        require("nvim-autopairs").setup(opts)
        -- setup cmp for autopairs
        local cmp_autopairs = require "nvim-autopairs.completion.cmp"
        require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end,
    },
    -- cmp sources plugins
    {
      "ray-x/lsp_signature.nvim",
      event = "VeryLazy",
      opts = {
        border = "rouded",
        hint_prefix = "👉 ",
      },
      config = function(_, opts) require'lsp_signature'.setup(opts) end
    },
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/vim-vsnip",
  },
  opts = {},
  config = function(_, opts)
    cmp_config(opts)
  end,
}

return M
