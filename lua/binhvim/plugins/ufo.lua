-- [nfnl] Compiled from fnl/binhvim/plugins/ufo.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_(...)
  return (require("ufo")).openAllFolds(...)
end
local function _2_(...)
  return (require("ufo")).closeAllFolds(...)
end
local function _3_()
  vim.o.foldcolumn = "1"
  vim.o.foldlevel = 99
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true
  return nil
end
local function _4_()
  return {"treesitter", "indent"}
end
return {"kevinhwang91/nvim-ufo", event = "LazyFile", dependencies = "kevinhwang91/promise-async", keys = {{"zR", _1_, desc = "Open all folds"}, {"zM", _2_, desc = "Close all folds"}}, init = _3_, opts = {provider_selector = _4_}}
