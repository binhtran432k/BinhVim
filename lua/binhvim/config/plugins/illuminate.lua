-- [nfnl] Compiled from fnl/binhvim/config/plugins/illuminate.fnl by https://github.com/Olical/nfnl, do not edit.
local function opts()
  return {delay = 300, large_file_cutoff = 2000, large_file_overrides = {providers = {"lsp"}}}
end
local function config()
  local illuminate = require("illuminate")
  local function _1_()
    return (require("illuminate")).goto_next_reference(false)
  end
  vim.keymap.set("n", "]]", _1_, {desc = "Next Reference"})
  local function _2_()
    return (require("illuminate")).goto_prev_reference(false)
  end
  vim.keymap.set("n", "[[", _2_, {desc = "Prev Reference"})
  local function _3_()
    local buffer = vim.api.nvim_get_current_buf()
    local function _4_()
      return (require("illuminate")).goto_next_reference(false)
    end
    vim.keymap.set("n", "]]", _4_, {buffer = buffer, desc = "Next Reference"})
    local function _5_()
      return (require("illuminate")).goto_prev_reference(false)
    end
    return vim.keymap.set("n", "[[", _5_, {buffer = buffer, desc = "Prev Reference"})
  end
  return vim.api.nvim_create_autocmd("FileType", {callback = _3_, group = vim.api.nvim_create_augroup("binhvim_illuminate_mapping", {clear = true})})
end
return {opts = opts, config = config}
