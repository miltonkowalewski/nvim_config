local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("* Installing Lazy.nvim")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local function is_work_environment()
  local workEnvironmentPath = vim.fn.getenv("WORK_ENVIRONMENT_PATH")
  if type(workEnvironmentPath) == "string" then
    local modifiedValue = string.gsub(workEnvironmentPath, "~", "")
    local cwd = vim.fn.getcwd() or ""
    if string.find(cwd, modifiedValue) then return true end
  end
  return false
end

WORK_ENVIRONMENT = is_work_environment()

-- Create LazyFile event to load without blocking ui
local plugins_tools = require("plugins.config.tools")
plugins_tools.lazy_file()

colorscheme_list = { "vscode", "gruvbox", "kanagawa", "tokyonight", "solarized-osaka", "fluoromachine" }

local colorscheme = require("core.lua_tools").getRandomValue(colorscheme_list)
require("lazy").setup({
  spec = {
    -- coding
    { import = "plugins.coding.codeium" },
    { import = "plugins.coding.comment" },
    { import = "plugins.coding.luasnip" },
    { import = "plugins.coding.nvim-cmp" },
    -- dap
    { import = "plugins.dap.nvim-dap" },
    -- { import = "plugins.dap.nvim-dap-virtual-text" },
    { import = "plugins.dap.neotest-python" },
    -- colorscheme
    { import = "plugins.colorscheme." .. colorscheme },
    -- editor
    { import = "plugins.editor.markdown-preview" },
    { import = "plugins.editor.nvim-hl-mdcodeblock" },
    { import = "plugins.editor.neo-tree" },
    { import = "plugins.editor.telescope" },
    { import = "plugins.editor.flash" },
    { import = "plugins.editor.nvim_context_vt" },
    { import = "plugins.editor.which-key" },
    { import = "plugins.editor.gitsigns" },
    { import = "plugins.editor.vim-illuminate" },
    { import = "plugins.editor.trouble" },
    { import = "plugins.editor.todo-comments" },
    { import = "plugins.editor.semshi" },
    { import = "plugins.editor.nvim-treesitter" },
    { import = "plugins.editor.headlines" },
    { import = "plugins.editor.zem" },
    { import = "plugins.editor.persistence" },
    { import = "plugins.editor.nvim-treesitter-context" },
    { import = "plugins.editor.nvim-window-picker" },
    { import = "plugins.editor.aerial" },
    { import = "plugins.editor.winshift" },
    -- formatting
    { import = "plugins.formatting.format-on-save" },
    -- lsp
    { import = "plugins.lsp.goto-preview" },
    { import = "plugins.lsp.nvim-lspconfig" },
    -- plugin_manager
    { import = "plugins.plugin-manager.mason" },
    -- ui
    { import = "plugins.ui.alpha-nvim" },
    { import = "plugins.ui.lualine" },
    { import = "plugins.ui.nvim-bqf" },
    { import = "plugins.ui.incline" },
    { import = "plugins.ui.noice" },
  },
  defaults = {
    lazy = false,
    version = false,             -- always use the latest git commit
  },
  checker = { enabled = false }, -- automatically check for plugin updates
  performance = {
    cache = {
      enabled = true,
      -- disable_events = {},
    },
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        -- "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  debug = false,
})

local has_theme, _ = pcall(require, colorscheme)
if has_theme then vim.cmd("colorscheme " .. colorscheme) end
