local u = require 'starscourge.utils'

-- Environment.
local env_file = os.getenv 'HOME' .. '/.private/nvim_env.lua'
if u.file_exists(env_file) then vim.cmd('luafile ' .. env_file) end

-- These have to be run first and in this order.
-- require 'starscourge.lazy'
require 'starscourge.packer'
require 'starscourge.theme'

-- Core.
require 'starscourge.options'
require 'starscourge.ui'
require 'starscourge.lang'

-- Run this last to ensure they do not get overridden.
require 'starscourge.keymaps'
