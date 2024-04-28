-- [nfnl] Compiled from fnl/binhvim/config/plugins/surround.fnl by https://github.com/Olical/nfnl, do not edit.
local function keys(_, keys0)
  local lazy_config = require("lazy.core.config")
  local plugin = lazy_config.spec.plugins["mini.surround"]
  local lazy_plugin = require("lazy.core.plugin")
  local opts = lazy_plugin.values(plugin, "opts", false)
  local mappings = {{opts.mappings.add, desc = "Add Surrounding", mode = {n = "v"}}, {opts.mappings.delete, desc = "Delete Surrounding"}, {opts.mappings.find, desc = "Find Right Surrounding"}, {opts.mappings.find_left, desc = "Find Left Surrounding"}, {opts.mappings.highlight, desc = "Highlight Surrounding"}, {opts.mappings.replace, desc = "Replace Surrounding"}, {opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`"}}
  local mappings0
  local function _1_(_241)
    return ((_241)[1] and (0 < #(_241)[1]))
  end
  mappings0 = vim.tbl_filter(_1_, mappings)
  return vim.list_extend(mappings0, keys0)
end
local function opts()
  return {mappings = {add = "gsa", delete = "gsd", find = "gsf", find_left = "gsF", highlight = "gsh", replace = "gsr", update_n_lines = "gsn"}}
end
return {opts = opts, keys = keys}
