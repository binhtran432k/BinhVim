-- [nfnl] Compiled from fnl/binhvim/extras/lang/yaml.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_(new_config)
  new_config.settings.yaml.schemas = (new_config.settings.yaml.schemas or {})
  return vim.list_extend(new_config.settings.yaml.schemas, ((require("schemastore")).yaml).schemas())
end
local function _2_(_, _0, add_on_attach)
  if (vim.fn.has("nvim-0.10") == 0) then
    local function _3_(client, _1)
      if (client.name == "yamlls") then
        client.server_capabilities.documentFormattingProvider = true
        return nil
      else
        return nil
      end
    end
    return add_on_attach(_3_)
  else
    return nil
  end
end
return {{"nvim-treesitter/nvim-treesitter", opts = {binh_ensure_installed = {yaml = true}}}, {"b0o/SchemaStore.nvim", lazy = true, version = false}, {"neovim/nvim-lspconfig", opts = {servers = {yamlls = {capabilities = {textDocument = {foldingRange = {lineFoldingOnly = true, dynamicRegistration = false}}}, on_new_config = _1_, settings = {yaml = {format = {enable = true}, validate = true, schemaStore = {url = "", enable = false}, keyOrdering = false}}}}, setup = {yamlls = _2_}}}}
