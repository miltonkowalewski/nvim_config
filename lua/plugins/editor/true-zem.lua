return {
  "Pocco81/true-zen.nvim",
  opts = {
    modes = { -- configurations per mode
      ataraxis = {
        shade = "dark", -- if `dark` then dim the padding windows, otherwise if it's `light` it'll brighten said windows
        backdrop = 0, -- percentage by which padding windows should be dimmed/brightened. Must be a number between 0 and 1. Set to 0 to keep the same background color
        minimum_writing_area = { -- minimum size of main window
          width = 70,
          height = 44,
        },
        quit_untoggles = true, -- type :q or :qa to quit Ataraxis mode
        padding = { -- padding windows
          left = 52,
          right = 52,
          top = 0,
          bottom = 0,
        },
        callbacks = { -- run functions when opening/closing Ataraxis mode
	open_pre = function()
		-- do some stuff
		vim.g.tz_disable_minimalist_open_pre = true
	end,
          open_pos = nil,
          close_pre = nil,
          close_pos = nil
        },
      },
      narrow = {
        --- change the style of the fold lines. Set it to:
        --- `informative`: to get nice pre-baked folds
        --- `invisible`: hide them
        --- function() end: pass a custom func with your fold lines. See :h foldtext
        folds_style = "informative",
        run_ataraxis = true, -- display narrowed text in a Ataraxis session
        callbacks = { -- run functions when opening/closing Narrow mode
          open_pre = nil,
          open_pos = nil,
          close_pre = nil,
          close_pos = nil
        },
      },
      focus = {
        callbacks = { -- run functions when opening/closing Focus mode
          open_pre = nil,
          open_pos = nil,
          close_pre = nil,
          close_pos = nil
        },
      }
    },
    integrations = {
      tmux = false, -- hide tmux status bar in (minimalist, ataraxis)
      kitty = { -- increment font size in Kitty. Note: you must set `allow_remote_control socket-only` and `listen_on unix:/tmp/kitty` in your personal config (ataraxis)
        enabled = false,
        font = "+3"
      },
      twilight = false, -- enable twilight (ataraxis)
      lualine = false -- hide nvim-lualine (ataraxis)
    },
  },
  keys = {
    { "<leader>Z",  mode = { "n" }, ":TZAtaraxis<CR>", desc = "Zen Mode" },
    { "<leader>zn", mode = { "n" }, ":TZNarrow<CR>", desc = "Zen Narrow" },
    { "<leader>zn", mode = { "v" }, ":'<,'>TZNarrow<CR>", desc = "Zen Narrow" },
    { '<leader>zf', mode = { "n" }, ":TZFocus<CR>", desc = "Zen Focus" },
    { '<leader>zm', mode = { "n" }, ":TZMinimalist<CR>", desc = "Zen Minimalist" },
    { '<leader>za', mode = { "n" }, ":TZAtaraxis<CR>", desc = "Zen Ataraxis" },
  },
}

