-- [nfnl] Compiled from fnl/binhvim/plugins/conform.fnl by https://github.com/Olical/nfnl, do not edit.
local prettier_3f = (vim.fs.find({".prettierrc", ".prettierrc.json", ".prettierrc.yml", ".prettierrc.yaml", ".prettierrc.json5", ".prettierrc.js", ".prettierrc.cjs", ".prettierrc.toml", "prettier.config.js", "prettier.config.cjs"}, {upward = true}))[1]
local biome_3f = (vim.fs.find({"biome.json"}, {upward = true}))[1]
local function filter_client(_1_)
  local _arg_2_ = _1_
  local name = _arg_2_["name"]
  if biome_3f then
    return ((name ~= "jsonls") and (name ~= "tsserver"))
  else
    return true
  end
end
local function _4_()
  return (require("conform")).format({lsp_fallback = true, filter = filter_client, quiet = false, timeout_ms = 3000, async = false})
end
local function _5_()
  return (require("conform")).format({formatters = {"injected"}, lsp_fallback = true, filter = filter_client, quiet = false, timeout_ms = 3000, async = false})
end
return {"stevearc/conform.nvim", cmd = "ConformInfo", keys = {{"<leader>cf", _4_, mode = {"n", "v"}, desc = "Format"}, {"<leader>cF", _5_, mode = {"n", "v"}, desc = "Format Injected Langs"}}, opts = {formatters_by_ft = {fennel = {"fnlfmt"}, lua = {"stylua"}, fish = {"fish_indent"}, sh = {"shfmt"}}}}
