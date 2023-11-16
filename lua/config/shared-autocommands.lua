-- [[ Autocommands ]]
local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- prevent Neovim from changing file mode when saving certain file types
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("PreventFileModeChange"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    vim.fn.system('chmod -x ' .. vim.fn.expand('%'))
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

