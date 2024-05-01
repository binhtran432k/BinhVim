-- [nfnl] Compiled from fnl/binhvim/plugins/bufferline.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_(_241)
  return require("mini.bufremove"):delete()(_241, false)
end
local function _2_(_241)
  return require("mini.bufremove"):delete()(_241, false)
end
local function _3_(_, opts)
  local _let_4_ = require("bufferline")
  local setup = _let_4_["setup"]
  setup(opts)
  local function _5_()
    local function _6_()
      return pcall(nvim_bufferline)
    end
    return vim.schedule(_6_)
  end
  return vim.api.nvim_create_autocmd("BufAdd", {callback = _5_})
end
return {"akinsho/bufferline.nvim", event = "VeryLazy", keys = {{"<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle Pin"}, {"<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Delete Non-Pinned Buffers"}, {"<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Delete Other Buffers"}, {"<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Delete Buffers to the Right"}, {"<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Delete Buffers to the Left"}, {"<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer"}, {"<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer"}, {"[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer"}, {"]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer"}, {"<leader>b[", "<cmd>BufferLineMovePrev<cr>", desc = "Move Buffer to Prev"}, {"<leader>b]", "<cmd>BufferLineMoveNext<cr>", desc = "Move Buffer to Next"}}, opts = {options = {close_command = _1_, right_mouse_command = _2_, diagnostics = "nvim_lsp", offsets = {{filetype = "neo-tree", text = "Neo-tree", highlight = "Directory", text_align = "left"}}, always_show_bufferline = false}}, config = _3_}
