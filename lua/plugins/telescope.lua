local M = {}

local options = function()
  return {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "node_modules", ".venv", ".git" },
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { "truncate" },
      winblend = 0,
      border = {},
      -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      borderchars = {
        "─",
        "",
        "─",
        "",
        "╭",
        "╮",
        "╯",
        "╰",
      },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      mappings = {
        n = { ["q"] = require("telescope.actions").close },
      },
    },
    extensions = {
      undo = {
        use_delta = true,
        side_by_side = true,
        diff_context_lines = 0,
        entry_format = "󰣜 #$ID, $STAT, $TIME",
        layout_strategy = "horizontal",
        layout_config = {
          preview_width = 0.70,
        },
        mappings = {
          i = {
            ["<cr>"] = require("telescope-undo.actions").yank_additions,
            ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
            ["<C-cr>"] = require("telescope-undo.actions").restore,
          },
        },
      },
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      }
    },
  }
end

M.lazy = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "debugloop/telescope-undo.nvim",
      cmd = "Telescope",
    },
    "nvim-treesitter/nvim-treesitter",
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    "nvim-lua/plenary.nvim"
  },
  cmd = "Telescope",
  opts = options,
  config = function(_, opts)
    require("telescope").setup(opts)
    require('telescope').load_extension('fzf')
    require("telescope").load_extension("undo")
  end,
  keys = {
    {"<leader>fc", mode = { "n", "v" }, "<cmd>Telescope git_branches<cr>", desc="Find Checkout Branch" },
    {"<leader>fz", mode = { "n", "v" }, "<cmd>Telescope colorscheme<cr>", desc="Find colorscheme" },
    {"<leader>fs", mode = { "n", "v" }, "<cmd>Telescope search_history<cr>", desc="Find Search History" },
    {"<leader>ff", mode = { "n", "v" }, "<cmd>Telescope find_files hidden=true<cr>", desc="Find Files" },
    {"<leader>fh", mode = { "n", "v" }, "<cmd>Telescope help_tags<cr>", desc="Find Help" },
    {"<leader>fd", mode = { "n", "v" }, "<cmd>Telescope diagnostics<cr>", desc="Find Diagnostics" },
    {"<leader>fr", mode = { "n", "v" }, "<cmd>Telescope oldfiles hidden=true<cr>", desc="Find Recently Opened Files" },
    {"<leader>fb", mode = { "n", "v" }, function()
      require('telescope.builtin').buffers({ sort_lastused = true, ignore_current_buffer = true })
    end, desc="Find Opened Buffers" },
    {"<leader>fg", mode = { "n", "v" }, "<cmd>Telescope live_grep hidden=true<cr>", desc="Find by Grep" },
    {"<leader>fM", mode = { "n", "v" }, "<cmd>Telescope man_pages<cr>", desc="Find Man Pages" },
    {"<leader>fk", mode = { "n", "v" }, "<cmd>Telescope keymaps<cr>", desc="Find Keymaps" },
    {"<leader>fp", mode = { "n", "v" }, "<cmd>Telescope projects<cr>", desc="Find Projects" },
    {"<C-f>", mode = { "n", "v" }, function()
      local current_word = vim.fn.expand('<cword>')
      require('telescope.builtin').current_buffer_fuzzy_find({
        use_regex=true,
        default_text = current_word,
        ctags_file="./tags",
        sorting_strategy = "ascending",
      })
    end, desc="Find in File" },
    {"<C-g>", mode = { "n", "v" }, function()
      local current_word = vim.fn.expand('<cword>')
      require('telescope.builtin').live_grep({
        use_regex=true,
        default_text = current_word,
        ctags_file="./tags",
        sorting_strategy = "ascending",
      })
    end, desc="Find in Project" },
  }
}

return M
