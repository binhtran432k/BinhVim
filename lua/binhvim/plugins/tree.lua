-- [nfnl] Compiled from fnl/binhvim/plugins/tree.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_(_241, _242)
  return (require("nvim-tree")).setup(_242)
end
return {"nvim-tree/nvim-tree.lua", version = "*", keys = {{"<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer"}, {"<leader>fe", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Explorer Focus File"}, {"<leader>fE", "<cmd>NvimTreeToggle %:p:h<cr>", desc = "Explorer Parent Directory"}, {"<leader>fp", "<cmd>NvimTreeToggle $PWD<cr>", desc = "Explorer PWD"}}, cmd = {"NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse"}, opts = {}, config = _1_}
