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
    if string.find(vim.fn.getcwd(), modifiedValue) then
      return true
    end
  end
  return false
end

WORK_ENVIRONMENT = is_work_environment()

-- [[ import theme ]]
local theme =
-- require("plugins.theme_miasma")
-- require("plugins.theme_kanagawa")
-- require("plugins.theme_ronny")
require("plugins.theme_night-owl")

local default_plugins = {
  require("plugins.comment_comment").lazy,
  require("plugins.comment_todo-comments").lazy,
  require("plugins.completition_cmp").lazy,
  require("plugins.dap_nvim-dap-ui").lazy,
  require("plugins.dap_nvim-dap-virtual-text").lazy,
  require("plugins.dap_nvim-dap").lazy,
  require("plugins.diagnostics_trouble").lazy,
  require("plugins.documentation_dooku").lazy,
  require("plugins.explorer_mini-files").lazy,
  require("plugins.explorer_nvimtree").lazy,
  require("plugins.finder_telescope").lazy,
  require("plugins.finder_wilder").lazy,
  require("plugins.format_format-on-save").lazy,
  require("plugins.git_diffview").lazy,
  require("plugins.git_gitsigns").lazy,
  require("plugins.git_vim-fugitive").lazy,
  require("plugins.icons_devicons").lazy,
  require("plugins.llm_codeium").lazy,
  require("plugins.lsp_goto-preview").lazy,
  require("plugins.lsp_lspconfig").lazy,
  require("plugins.lsp_nvim-lint").lazy,
  require("plugins.motion_hop").lazy,
  require("plugins.motion_nvim-window-picker").lazy,
  require("plugins.pck_manager_mason-lspconfig").lazy,
  require("plugins.pck_manager_mason").lazy,
  require("plugins.pck_manager_mini").lazy,
  require("plugins.preview_headlines").lazy,
  require("plugins.preview_markdown-preview").lazy,
  require("plugins.session_neovim-session-manager").lazy,
  require("plugins.statusline_bufferline").lazy,
  require("plugins.statusline_lualine").lazy,
  require("plugins.surround_mini-surround").lazy,
  require("plugins.symbols_aerial").lazy,
  require("plugins.syntax_treesitter").lazy,
  require("plugins.syntax_twilight").lazy,
  require("plugins.task_run_overseer").lazy,
  require("plugins.terminal_toggleterm").lazy,
  require("plugins.test_neotest-python").lazy,
  require("plugins.test_nvim-coverage").lazy,
  require("plugins.tool_plenary").lazy,
  require("plugins.tool_suda").lazy,
  require("plugins.tool_treesitter-context").lazy,
  require("plugins.tools_ssr").lazy,
  require("plugins.ui_dressing").lazy,
  require("plugins.ui_nvim-scrollbar").lazy,
  require("plugins.ui_stickbuf").lazy,
  require("plugins.ui_which-key").lazy,
  require("plugins.window_winshift").lazy,
  -- [[ Themes ]]
  theme.lazy,
  -- [[ End plugins here ]]
}

require("lazy").setup(default_plugins, {
  defaults = { lazy = true },
  ui = {
    icons = {
      ft = "",
      lazy = "󰂠 ",
      loaded = "",
      not_loaded = "",
    },
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        -- "rplugin", -- Not disabled because `wilder` plugin
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
        "editorconfig",
      },
    },
  },
})

theme.load()
