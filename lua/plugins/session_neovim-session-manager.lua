local M = {}

-- Session management [session]
-- https://github.com/Shatur/neovim-session-manager
-- This plugin save your session when you write a buffer.
-- It also display a Telescope menu to restore saved sessions.
-- Sessions are saved by directory.
--
-- If you prefer to manually manage sessions using <space>S
-- you can disable autosaving sessions here.
--
-- If you prefer to load the last session automatically when opening nvim,
-- you can delete all settings and just set "lazy = false".
M.lazy = {
  "Shatur/neovim-session-manager",
  event = "User BaseFile",
  cmd = "SessionManager",
  opts = function()
    local config = require('session_manager.config')
    return {
      autoload_mode = config.AutoloadMode.Disabled,                        -- Do not autoload on startup.
      autosave_last_session = false,                                       -- Don't auto save session on exit vim.
      autosave_only_in_session = false,                                    -- We allow overriding sessions.
    }
  end,
  config = function(_, opts)
    local session_manager = require('session_manager')
    session_manager.setup(opts)

    -- Auto save session only on write buffer.
    -- This avoid inconsistencies when closing multiple instances of the same session.
    local augroup = vim.api.nvim_create_augroup
    local autocmd = vim.api.nvim_create_autocmd
    autocmd({ 'BufWritePre' }, {
      group = augroup("session_manager_autosave_on_write", { clear = true }),
      callback = function ()
        if vim.bo.filetype ~= 'git' and
          not vim.bo.filetype ~= 'gitcommit' and
          not vim.bo.filetype ~= 'gitrebase'
        then
          -- Important: Be aware the next line will close anything non-buffer,
          -- (notifications, neotree, aerial...)
          -- because saving that stuff would break the GUI on restore.
          -- If this is important to you, use the event 'VimLeavePre' instead.
          -- But doing so, your session won't be saved on power loss.
          session_manager.save_current_session()
        end
      end
    })
  end,
  keys = {
    { "<leader>0sd", mode = { "n" }, ":SessionManager load_last_session<CR>", desc="Select and load session. (Your current session won't appear on the list)" },
    { "<leader>0sl", mode = { "n" }, ":SessionManager load_last_session<CR>", desc="Will remove all buffers and :source the last saved session." },
    { "<leader>0sc", mode = { "n" }, ":SessionManager load_last_session<CR>", desc="Will remove all buffers and :source the last saved session file of the current dirtectory" },
    { "<leader>0ss", mode = { "n" }, ":SessionManager save_current_session<CR>", desc="Saves/creates current directory as a session in sessions_dir" },
    { "<leader>0sd", mode = { "n" }, ":SessionManager delete_session<CR>", desc="Select and delete session." },
  },
}
return M
