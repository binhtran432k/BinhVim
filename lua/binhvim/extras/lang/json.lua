-- [nfnl] Compiled from fnl/binhvim/extras/lang/json.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_(new_config)
  new_config.settings.json.schemas = (new_config.settings.json.schemas or {})
  return vim.list_extend(new_config.settings.json.schemas, ((require("schemastore")).json).schemas())
end
return {{"nvim-treesitter/nvim-treesitter", opts = {binh_ensure_installed = {json = true, json5 = true, jsonc = true}}}, {"b0o/SchemaStore.nvim", lazy = true, version = false}, {"neovim/nvim-lspconfig", opts = {servers = {jsonls = {on_new_config = _1_, settings = {json = {format = {enable = true}, validate = {enable = true}}}}}}}}
