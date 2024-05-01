-- [nfnl] Compiled from fnl/binhvim/plugins/notify.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return (require("notify")).dismiss({silent = true, pending = true})
end
local function _2_()
  return math.floor((vim.o.lines * 0.75))
end
local function _3_()
  return math.floor((vim.o.columns * 0.75))
end
local function _4_(_241)
  return vim.api.nvim_win_set_config(_241, {zindex = 100})
end
local function _5_()
  local function _6_()
    vim.notify = require("notify")
    return nil
  end
  return vim.api.nvim_create_autocmd("User", {callback = _6_, pattern = "VeryLazy"})
end
return {"rcarriga/nvim-notify", keys = {{"<leader>un", _1_, desc = "Dismiss All Notifications"}}, opts = {stages = "static", timeout = 3000, max_height = _2_, max_width = _3_, on_open = _4_}, init = _5_}
