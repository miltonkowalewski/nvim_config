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

-- [[ import theme ]]
local theme =
-- require("plugins.theme-miasma")
-- require("plugins.theme-kanagawa")
-- require("plugins.theme-ronny")
require("plugins.theme-oxocarbon")

local default_plugins = {
  require("plugins.plenary").lazy,
  require("plugins.devicons").lazy,
  require("plugins.treesitter").lazy,
  require("plugins.gitsigns").lazy,
  require("plugins.lspconfig").lazy,
  require("plugins.mason-lspconfig").lazy,
  require("plugins.mason").lazy,
  require("plugins.cmp").lazy,
  require("plugins.nvimtree").lazy,
  require("plugins.telescope").lazy,
  require("plugins.which-key").lazy,
  require("plugins.trouble").lazy,
  require("plugins.hop").lazy,
  -- require("plugins.nvim-dap-python").lazy,
  require("plugins.nvim-dap").lazy,
  require("plugins.nvim-dap-ui").lazy,
  require("plugins.nvim-dap-virtual-text").lazy,
  require("plugins.goto-preview").lazy,
  -- require("plugins.chatgpt").lazy,
  require("plugins.todo-comments").lazy,
  require("plugins.neotest-python").lazy,
  require("plugins.comment").lazy,
  require("plugins.mini").lazy,
  require("plugins.lualine").lazy,
  require("plugins.toggleterm").lazy,
  require("plugins.rnvimr").lazy,
  require("plugins.stickbuf").lazy,
  require("plugins.nvim-window-picker").lazy,
  -- require("plugins.neotree").lazy,
  require("plugins.neovim-session-manager").lazy,
  require("plugins.suda").lazy,
  -- require("plugins.simplyfold").lazy,
  require("plugins.formatonsave").lazy,
  require("plugins.nvim-scrollbar").lazy,
  require("plugins.dressing").lazy,
  require("plugins.vim-fugitive").lazy,
  require("plugins.dooku").lazy,
  require("plugins.markdown-preview").lazy,
  require("plugins.overseer").lazy,
  -- require("plugins.neural-chatgpt").lazy,
  require("plugins.nvim-coverage").lazy,
  require("plugins.twilight").lazy,
  require("plugins.markmap").lazy,
  require("plugins.winshift").lazy,
  require("plugins.hardtime").lazy,
  require("plugins.wilder").lazy,
  require("plugins.treesitter-context").lazy,
  require("plugins.diffview").lazy,
  require("plugins.neogen").lazy,
  require("plugins.ai-gen").lazy,
  require("plugins.transparent").lazy,
  require("plugins.theme-night-owl").lazy,
  require("plugins.tabline-bufferline").lazy,
  require("plugins.ai-codeium").lazy,
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
