-- [nfnl] Compiled from fnl/binhvim/config/keymaps.fnl by https://github.com/Olical/nfnl, do not edit.
local function setup()
  vim.keymap.set("n", "j", "v:count || mode(1)[0:1] == 'no' ? 'j' : 'gj'", {expr = true}, {desc = "Move Cursor Down (Allow Wrapped)"})
  vim.keymap.set("n", "k", "v:count || mode(1)[0:1] == 'no' ? 'k' : 'gk'", {expr = true}, {desc = "Move Cursor Up (Allow Wrapped)"})
  vim.keymap.set("n", "<c-s>", "<cmd>silent! update | redraw<cr>", {noremap = true, silent = true}, {desc = "Save"})
  vim.keymap.set({"i", "x"}, "<c-s>", "<esc><cmd>silent! update | redraw<cr>", {noremap = true, silent = true}, {desc = "Save and go to Normal mode"})
  vim.keymap.set("n", "<c-h>", "<c-w>h", {noremap = true, silent = true}, {desc = "Move Cursor Left Buffer"})
  vim.keymap.set("n", "<c-j>", "<c-w>j", {noremap = true, silent = true}, {desc = "Move Cursor Down Buffer"})
  vim.keymap.set("n", "<c-k>", "<c-w>k", {noremap = true, silent = true}, {desc = "Move Cursor Up Buffer"})
  vim.keymap.set("n", "<c-l>", "<c-w>l", {noremap = true, silent = true}, {desc = "Move Cursor Right Buffer"})
  vim.keymap.set("n", "<c-up>", "<cmd>resize +2<cr>", {noremap = true, silent = true}, {desc = "Resize Window Up"})
  vim.keymap.set("n", "<c-down>", "<cmd>resize -2<cr>", {noremap = true, silent = true}, {desc = "Resize Window Down"})
  vim.keymap.set("n", "<c-left>", "<cmd>vertical resize +2<cr>", {noremap = true, silent = true}, {desc = "Resize Window Left"})
  vim.keymap.set("n", "<c-right>", "<cmd>vertical resize -2<cr>", {noremap = true, silent = true}, {desc = "Resize Window Right"})
  vim.keymap.set({"n", "v"}, "<leader>q", "<cmd>qa!<cr>", {noremap = true, silent = true}, {desc = "Quit"})
  return vim.keymap.set("n", "<enter>", "<cmd>nohlsearch<cr>", {noremap = true, silent = true}, {desc = "Clear highlight"})
end
return {setup = setup}
