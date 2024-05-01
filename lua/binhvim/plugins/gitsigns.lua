-- [nfnl] Compiled from fnl/binhvim/plugins/gitsigns.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_(buffer)
  local gs = package.loaded.gitsigns
  vim.keymap.set("n", "]h", gs.next_hunk, {buffer = buffer, desc = "Next Hunk"})
  vim.keymap.set("n", "[h", gs.prev_hunk, {buffer = buffer, desc = "Prev Hunk"})
  vim.keymap.set({"n", "v"}, "<leader>ghs", ":Gitsigns stage_hunk<CR>", {buffer = buffer, desc = "Stage Hunk"})
  vim.keymap.set({"n", "v"}, "<leader>ghr", ":Gitsigns reset_hunk<CR>", {buffer = buffer, desc = "Reset Hunk"})
  vim.keymap.set("n", "<leader>ghS", gs.stage_buffer, {buffer = buffer, desc = "Stage Buffer"})
  vim.keymap.set("n", "<leader>ghu", gs.undo_stage_hunk, {buffer = buffer, desc = "Undo Stage Hunk"})
  vim.keymap.set("n", "<leader>ghR", gs.reset_buffer, {buffer = buffer, desc = "Reset Buffer"})
  vim.keymap.set("n", "<leader>ghp", gs.preview_hunk_inline, {buffer = buffer, desc = "Preview Hunk Inline"})
  local function _2_()
    return gs.blame_line({full = true})
  end
  vim.keymap.set("n", "<leader>ghb", _2_, {buffer = buffer, desc = "Blame Line"})
  vim.keymap.set("n", "<leader>ghd", gs.diffthis, {buffer = buffer, desc = "Diff This"})
  local function _3_()
    return gs.diffthis("~")
  end
  vim.keymap.set("n", "<leader>ghD", _3_, {buffer = buffer, desc = "Diff This ~"})
  return vim.keymap.set({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>", {buffer = buffer, desc = "GitSigns Select Hunk"})
end
return {"lewis6991/gitsigns.nvim", event = "LazyFile", opts = {on_attach = _1_}}
