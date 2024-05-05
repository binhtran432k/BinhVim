-- [nfnl] Compiled from fnl/binhvim/extras/lang/web.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_(_, opts)
  local tw = require("lspconfig.server_configurations.tailwindcss")
  local filetypes
  local function _2_()
    local tbl_14_auto = {}
    for _0, ft in ipairs(tw.default_config.filetypes) do
      local k_15_auto, v_16_auto = ft, true
      if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
        tbl_14_auto[k_15_auto] = v_16_auto
      else
      end
    end
    return tbl_14_auto
  end
  filetypes = (opts.filetypes or _2_())
  for ft, enable in pairs(opts.filetypes_include) do
    if enable then
      filetypes[ft] = true
    else
    end
  end
  for ft, enable in pairs(opts.filetypes_exclude) do
    if enable then
      filetypes[ft] = false
    else
    end
  end
  do
    local tbl_17_auto = {}
    local i_18_auto = #tbl_17_auto
    for ft, enable in pairs(filetypes) do
      local val_19_auto
      if enable then
        val_19_auto = ft
      else
        val_19_auto = nil
      end
      if (nil ~= val_19_auto) then
        i_18_auto = (i_18_auto + 1)
        do end (tbl_17_auto)[i_18_auto] = val_19_auto
      else
      end
    end
    opts.filetypes = tbl_17_auto
  end
  return false
end
local function _8_(_, opts)
  local format_kinds = opts.formatting.format
  local function _9_(entry, item)
    format_kinds(entry, item)
    return (require("tailwindcss-colorizer-cmp")).formatter(entry, item)
  end
  opts.formatting.format = _9_
  return nil
end
return {{"neovim/nvim-lspconfig", opts = {servers = {tailwindcss = {filetypes_exclude = {markdown = true}, filetypes_include = {}}, biome = {}, cssls = {}, html = {}, emmet_language_server = {}}, setup = {tailwindcss = _1_}}}, {"nvim-treesitter/nvim-treesitter", opts = {binh_ensure_installed = {css = true, scss = true}}}, {"hrsh7th/nvim-cmp", dependencies = {"roobert/tailwindcss-colorizer-cmp.nvim", config = true}, opts = _8_}}
