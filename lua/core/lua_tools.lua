local M = {}

---@param original table
M.shallow_copy = function(original)
  local copy = {}
  for key, value in pairs(original) do
    copy[key] = value
  end
  return copy
end

function M.fg(name)
  ---@type {foreground?:number}?
  ---@diagnostic disable-next-line: deprecated
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name }) or vim.api.nvim_get_hl_by_name(name, true)
  ---@diagnostic disable-next-line: undefined-field
  local fg = hl and (hl.fg or hl.foreground)
  return fg and { fg = string.format("#%06x", fg) } or nil
end

math.randomseed(os.time())

function M.getRandomValue(list)
  local randomIndex = math.random(1, #list) -- Generate a random index within the range of the list
  return list[randomIndex] -- Retrieve the value at the random index
end

return M
