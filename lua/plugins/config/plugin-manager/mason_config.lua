local M = {}

M.registry = function(ensure_installed_table)
  local mason_registry = require("mason-registry")
  mason_registry:on("package:install:success", function()
    vim.defer_fn(
      function()
        require("lazy.core.handler.event").trigger({
          event = "FileType",
          buf = vim.api.nvim_get_current_buf(),
        })
      end,
      100
    )
  end)
  local function ensure_installed()
    for _, tool in ipairs(ensure_installed_table) do
      local p = mason_registry.get_package(tool)
      if not p:is_installed() then p:install() end
    end
  end
  if mason_registry.refresh then
    mason_registry.refresh(ensure_installed)
  else
    ensure_installed()
  end
end

return M
