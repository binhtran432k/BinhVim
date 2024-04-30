-- [nfnl] Compiled from fnl/binhvim/plugins/illuminate.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local illuminate = require("illuminate")
  local function _2_()
    return (require("illuminate")).goto_next_reference(false)
  end
  vim.keymap.set("n", "]]", _2_, {desc = "Next Reference"})
  local function _3_()
    return (require("illuminate")).goto_prev_reference(false)
  end
  vim.keymap.set("n", "[[", _3_, {desc = "Prev Reference"})
  local function _4_()
    local buffer = vim.api.nvim_get_current_buf()
    local function _5_()
      return (require("illuminate")).goto_next_reference(false)
    end
    vim.keymap.set("n", "]]", _5_, {buffer = buffer, desc = "Next Reference"})
    local function _6_()
      return (require("illuminate")).goto_prev_reference(false)
    end
    return vim.keymap.set("n", "[[", _6_, {buffer = buffer, desc = "Prev Reference"})
  end
  return vim.api.nvim_create_autocmd("FileType", {callback = _4_, group = vim.api.nvim_create_augroup("binhvim_illuminate_mapping", {clear = true})})
end
return {"RRethy/vim-illuminate", event = "LazyFile", keys = {{"]]", desc = "Next Reference"}, {"[[", desc = "Prev Reference"}}, opts = {delay = 300, large_file_cutoff = 2000, large_file_overrides = {providers = {"lsp"}}}, config = _1_}
