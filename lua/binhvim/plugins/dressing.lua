-- [nfnl] Compiled from fnl/binhvim/plugins/dressing.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local function _2_(...)
    do end (require("lazy")).load({plugins = {"dressing.nvim"}})
    return vim.ui.select(...)
  end
  vim.ui.select = _2_
  local function _3_(...)
    do end (require("lazy")).load({plugins = {"dressing.nvim"}})
    return vim.ui.input(...)
  end
  vim.ui.input = _3_
  return nil
end
return {"stevearc/dressing.nvim", lazy = true, opts = {input = {insert_only = false}}, init = _1_}
