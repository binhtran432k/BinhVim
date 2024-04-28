-- [nfnl] Compiled from fnl/binhvim/config/plugins/whichkey.fnl by https://github.com/Olical/nfnl, do not edit.
local function opts()
  return {plugins = {spelling = true}, defaults = {mode = {n = "v"}, g = {name = "+goto"}, gs = {name = "+surround"}, z = {name = "+fold"}, ["["] = {name = "+next"}, ["]"] = {name = "+prev"}, ["<leader><tab>"] = {name = "+tabs"}, ["<leader>b"] = {name = "+buffer"}, ["<leader>c"] = {name = "+code"}, ["<leader>f"] = {name = "+file/find"}, ["<leader>g"] = {name = "+git"}, ["<leader>gh"] = {name = "+hunks"}, ["<leader>q"] = {name = "+quit/session"}, ["<leader>s"] = {name = "+search"}, ["<leader>u"] = {name = "+ui"}, ["<leader>w"] = {name = "+windows"}, ["<leader>x"] = {name = "+diagnostics/quickfix"}}}
end
local function config(_, opts0)
  local wk = require("which-key")
  wk.setup(opts0)
  return wk.register(opts0.defaults)
end
return {opts = opts, config = config}
