-- [nfnl] Compiled from fnl/binhvim/config/plugins/conform.fnl by https://github.com/Olical/nfnl, do not edit.
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
  local function _5_()
    return (require("conform")).format({timeout_ms = 3000, async = false, lsp_fallback = true, filter = filter_client, quiet = false})
  end
  local function _6_()
    return (require("conform")).format({formatters = {"injected"}, timeout_ms = 3000, async = false, lsp_fallback = true, filter = filter_client, quiet = false})
  end
  return {{"<leader>cf", _5_, mode = {"n", "v"}, desc = "Format"}, {"<leader>cF", _6_, mode = {"n", "v"}, desc = "Format Injected Langs"}}
end
local function _7_()
  return {formatters_by_ft = {fennel = {"fnlfmt"}}}
end
return {keys = _4_, opts = _7_}
