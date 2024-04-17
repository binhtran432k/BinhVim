-- [nfnl] Compiled from fnl/binhvim/init.fnl by https://github.com/Olical/nfnl, do not edit.
vim.uv = (vim.uv or vim.loop)
local function setup(opts)
  local _let_1_ = require("binhvim.config")
  local setup0 = _let_1_["setup"]
  return setup0(opts)
end
return {setup = setup}
