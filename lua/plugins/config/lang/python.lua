-- NOTE: Disabled used only as example to load after Lazy nvim done
local mason_setup = function()
  vim.api.nvim_create_autocmd("User", {
    once = true,
    pattern = { "LazyDone" },
    callback = function()
      -- NOTE: Logic after done here
    end,
  })
end
