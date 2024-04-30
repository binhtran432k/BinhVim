-- [nfnl] Compiled from fnl/binhvim/plugins/spectre.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return (require("spectre")).open()
end
return {"nvim-pack/nvim-spectre", cmd = "Spectre", opts = {open_cmd = "noswapfile vnew"}, keys = {{"<leader>sr", _1_, desc = "Replace in Files (Spectre)"}}, build = false}
