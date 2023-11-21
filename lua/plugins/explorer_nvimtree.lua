local M = {}

local options = function()
  return {
    filters = {
      dotfiles = false,
      exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
    },
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true,
    },
    view = {
      adaptive_size = true,
      side = "left",
      -- width = 30,
      preserve_window_proportions = true,
    },
    git = {
      enable = false,
      ignore = true,
    },
    filesystem_watchers = {
      enable = true,
    },
    actions = {
      open_file = {
        resize_window = true,
      },
    },
    renderer = {
      root_folder_label = false,
      highlight_git = false,
      highlight_opened_files = "none",

      indent_markers = {
        enable = true,
        icons = {
          corner = "└ ",
          edge = "│ ",
          item = "│ ",
          none = "  ",
        },
      },

      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = false,
        },

        glyphs = {
          default = "",
          symlink = "",
          folder = {
            empty = "",
            empty_open = "",
            default = "",
            open = "",
            symlink = "",
            symlink_open = "",
            arrow_open = "",
            arrow_closed = "",
          },
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
  }
end

local keys = {
  { "<leader>et", "<cmd>NvimTreeToggle<cr>", desc = "File Explorer" },
}

M.lazy = {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  opts = options,
  config = function(_, opts)
    require("nvim-tree").setup(opts)
    vim.g.nvimtree_side = opts.view.side
  end,
  keys = keys,
}

return M
