return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
      },
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
      },
    },
    keys = {
      { "<leader>fc", mode = { "n", "v" }, "<cmd>Telescope git_branches<cr>",           desc = "Find Checkout Branch" },
      { "<leader>fz", mode = { "n", "v" }, "<cmd>Telescope colorscheme<cr>",            desc = "Find colorscheme" },
      { "<leader>fs", mode = { "n", "v" }, "<cmd>Telescope search_history<cr>",         desc = "Find Search History" },
      { "<leader>ff", mode = { "n", "v" }, "<cmd>Telescope find_files hidden=true<cr>", desc = "Find Files" },
      { "<leader>fh", mode = { "n", "v" }, "<cmd>Telescope help_tags<cr>",              desc = "Find Help" },
      { "<leader>fd", mode = { "n", "v" }, "<cmd>Telescope diagnostics<cr>",            desc = "Find Diagnostics" },
      {
        "<leader>fr",
        mode = { "n", "v" },
        "<cmd>Telescope oldfiles hidden=true<cr>",
        desc = "Find Recently Opened Files",
      },
      {
        "<leader>fb",
        mode = { "n", "v" },
        function() require("telescope.builtin").buffers({ sort_lastused = true, ignore_current_buffer = true }) end,
        desc = "Find Opened Buffers",
      },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      {
        "<leader>fg",
        mode = { "n", "v" },
        "<cmd>:lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
        desc = "Find by Grep",
      },
      { "<leader>fM", mode = { "n", "v" },        "<cmd>Telescope man_pages<cr>", desc = "Find Man Pages" },
      { "<leader>fk", mode = { "n", "v" },        "<cmd>Telescope keymaps<cr>",   desc = "Find Keymaps" },
      { "<leader>fp", mode = { "n", "v" },        "<cmd>Telescope projects<cr>",  desc = "Find Projects" },
      {
        "<C-f>",
        mode = { "n", "v" },
        function()
          local current_word = vim.fn.expand("<cword>")
          require("telescope.builtin").current_buffer_fuzzy_find({
            word_match = "-w",
            use_regex = true,
            default_text = current_word,
            ctags_file = "./tags",
            sorting_strategy = "ascending",
          })
        end,
        desc = "Find in File",
      },
      {
        "<C-g>",
        mode = { "n" },
        function() require("telescope-live-grep-args.shortcuts").grep_word_under_cursor({ quote = true, trim = true }) end,
        desc = "Find in Project (normal)",
      },
      {
        "<C-g>",
        mode = { "v" },
        function() require("telescope-live-grep-args.shortcuts").grep_visual_selection({ quote = true, trim = true }) end,
        desc = "Find in Project (visual)",
      },
    },
    opts = function()
      local actions = require("telescope.actions")
      local telescope_opts = {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          file_ignore_patterns = { "node_modules", "\\.venv", "\\.git/" }, -- regex type
          -- open files in the first window that is an actual file.
          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then return win end
            end
            return 0
          end,
          mappings = {
            i = {
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
            },
            n = {
              ["q"] = actions.close,
            },
          },
          extensions = {
            fzf = {
              fuzzy = true,                   -- false will only do exact matching
              override_generic_sorter = true, -- override the generic sorter
              override_file_sorter = true,    -- override the file sorter
              case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
              -- the default case_mode is "smart_case"
            },
            live_grep_args = {
              auto_quoting = true, -- enable/disable auto-quoting
              -- define mappings, e.g.
              -- mappings = { -- extend mappings
              --   i = {
              --     ["<C-k>"] = lga_actions.quote_prompt(),
              --     ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              --   },
              -- },
              -- ... also accepts theme settings, for example:
              -- theme = "dropdown", -- use dropdown theme
              -- theme = { }, -- use own theme spec
              layout_config = { mirror = true }, -- mirror preview pane
            },
          },
        },
      }
      local has_trouble, _ = pcall(require, "trouble.providers.telescope")
      if has_trouble then
        local open_with_trouble = function(...) return require("trouble.providers.telescope").open_with_trouble(...) end
        local open_selected_with_trouble = function(...)
          return require("trouble.providers.telescope").open_selected_with_trouble(...)
        end
        local use_trouble_mapping = {
          ["<c-t>"] = open_with_trouble,
          ["<a-t>"] = open_selected_with_trouble,
        }
        for key, value in pairs(use_trouble_mapping) do
          telescope_opts.defaults.mappings.i[key] = value
        end
      end

      return telescope_opts
    end,
    config = function(_, opts)
      require("telescope").load_extension("live_grep_args")
      require("telescope").load_extension("fzf")
      require("telescope").setup(opts)
    end,
  },
}
