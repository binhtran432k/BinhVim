-- [nfnl] Compiled from fnl/binhvim/plugins/lualine.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  vim.g.lualine_laststatus = vim.o.laststatus
  if (0 < vim.fn.argc(-1)) then
    vim.o.statusline = " "
    return nil
  else
    vim.o.laststatus = 0
    return nil
  end
end
local function _3_()
  do
    local lualine_require = require("lualine_require")
    lualine_require.require = require
  end
  vim.o.laststatus = vim.g.lualine_laststatus
  local debug_color = string.format("#%06x", (vim.api.nvim_get_hl_by_name("Debug", true)).foreground)
  local special_color = string.format("#%06x", (vim.api.nvim_get_hl_by_name("Special", true)).foreground)
  local function _4_()
    return ("\239\145\175  " .. (require("dap")).status())
  end
  local function _5_()
    return (package.loaded.dap and ((require("dap")).status() ~= ""))
  end
  local function _6_()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
      return {added = gitsigns.added, modified = gitsigns.changed, removed = gitsigns.removed}
    else
      return nil
    end
  end
  local function _8_()
    return ("\239\144\186 " .. os.date("%R"))
  end
  return {options = {theme = "auto", globalstatus = true, component_separators = {left = "|", right = "|"}, section_separators = {left = "", right = ""}, disabled_filetypes = {statusline = {"dashboard", "alpha", "starter"}}}, sections = {lualine_a = {"mode"}, lualine_b = {"branch"}, lualine_c = {"diagnostics", {"filetype", icon_only = true, separator = ""}, {"filename", padding = {left = 0, right = 0}}}, lualine_x = {{_4_, cond = _5_, color = {fg = debug_color}}, {(require("lazy.status")).updates, cond = (require("lazy.status")).has_updates, color = {fg = special_color}}, {"diff", source = _6_}}, lualine_y = {"progress", "location"}, lualine_z = {_8_}}, extensions = {"neo-tree", "nvim-tree", "lazy"}}
end
return {"nvim-lualine/lualine.nvim", event = "VeryLazy", init = _1_, opts = _3_}
