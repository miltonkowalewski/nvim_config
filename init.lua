require("config.options") -- [[ Options ]]
local keymaps = require("config.keymaps") -- [[ Keymaps ]]
keymaps.vim()
require("config.autocommands") -- [[ Autocommands ]]
require("config.lazy") -- [[ Load Lazy ]]
require("config.color") -- [[ Substitute colorscheme colors ]]
