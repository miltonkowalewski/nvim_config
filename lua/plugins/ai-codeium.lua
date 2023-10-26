local M = {}

M.lazy = {
-- https://github.com/Exafunction/codeium.vim
  "Exafunction/codeium.vim",
  event = 'BufEnter',
  init = function()
    vim.g.codeium_disable_bindings = 1
    vim.g.codeium_no_map_tab = 1
  end,
  keys = {
    { '<C-/>', mode={ 'i' }, function () vim.api.nvim_input(vim.fn['codeium#Accept']()) end,  desc = "Codeium" },
    { '<C-[>',mode={ 'i' }, function() return vim.fn['codeium#CycleCompletions'](1) end,  desc = "Codeium" },
    { '<C-]>',mode={ 'i' }, function() return vim.fn['codeium#CycleCompletions'](-1) end,  desc = "Codeium" },
    { '<C-c>', mode={ 'i' }, function() return vim.fn['codeium#Clear']() end,  desc = "Codeium" },
    { '<leader>0cd', ":Codeium Disable <CR>",  desc = "Codeium Disable" },
    { '<leader>0ce', ":Codeium Enable <CR>",  desc = "Codeium Enable" },
  }
}

return M
