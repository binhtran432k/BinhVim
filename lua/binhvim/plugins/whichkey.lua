-- [nfnl] Compiled from fnl/binhvim/plugins/whichkey.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_(_, opts)
  local wk = require("which-key")
  wk.setup(opts)
  for _0, wk_reg in pairs(opts.binh_register) do
    wk.register(wk_reg)
  end
  return nil
end
return {"folke/which-key.nvim", event = "VeryLazy", cmd = "WhichKey", opts = {plugins = {spelling = true}, binh_register = {defaults = {mode = {"n", "v"}, g = {name = "+goto"}, gs = {name = "+surround"}, z = {name = "+fold"}, ["["] = {name = "+next"}, ["]"] = {name = "+prev"}, ["<leader><tab>"] = {name = "+tabs"}, ["<leader>b"] = {name = "+buffer"}, ["<leader>c"] = {name = "+code"}, ["<leader>f"] = {name = "+file/find"}, ["<leader>g"] = {name = "+git"}, ["<leader>gh"] = {name = "+hunks"}, ["<leader>q"] = {name = "+quit/session"}, ["<leader>s"] = {name = "+search"}, ["<leader>u"] = {name = "+ui"}, ["<leader>w"] = {name = "+windows"}, ["<leader>x"] = {name = "+diagnostics/quickfix"}}}}, config = _1_}
