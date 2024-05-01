-- [nfnl] Compiled from fnl/binhvim/plugins/indentscope.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_(_, opts)
  local indentscope = require("mini.indentscope")
  local none_animation = indentscope.gen_animation.none()
  return vim.tbl_deep_extend("force", opts, {symbol = "\226\148\130", options = {try_as_border = true}, draw = {delay = 300, animation = none_animation}})
end
local function _2_()
  local function _3_()
    vim.b.miniindentscope_disable = true
    return nil
  end
  return vim.api.nvim_create_autocmd("FileType", {pattern = {"help", "alpha", "dashboard", "neo-tree", "Trouble", "trouble", "lazy", "mason", "notify", "toggleterm", "lazyterm"}, callback = _3_})
end
return {"echasnovski/mini.indentscope", event = "LazyFile", opts = _1_, init = _2_, version = false}
