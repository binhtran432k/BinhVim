-- [nfnl] Compiled from fnl/binhvim/config/plugins/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_(plugin)
end
local function _2_()
  return {highlight = {enable = true}, indent = {enable = true}, ensure_installed = {}, binh_ensure_installed = {bash = true, c = true, diff = true, fennel = true, html = true, javascript = true, jsdoc = true, json = true, jsonc = true, lua = true, luadoc = true, luap = true, markdown = true, markdown_inline = true, python = true, query = true, regex = true, toml = true, tsx = true, typescript = true, vim = true, vimdoc = true, xml = true, yaml = true}, incremental_selection = {enable = true, keymaps = {init_selection = "<c-space>", node_incremental = "<c-space>", node_decremental = "<bs>", scope_incremental = false}}, textobjects = {move = {enable = true, goto_next_start = {[{"]f"}] = "@function.outer", [{"]c"}] = "@class.outer"}, goto_next_end = {[{"]F"}] = "@function.outer", [{"]C"}] = "@class.outer"}, goto_previous_start = {[{"[f"}] = "@function.outer", [{"[c"}] = "@class.outer"}, goto_previous_end = {[{"[F"}] = "@function.outer", [{"[C"}] = "@class.outer"}}}}
end
local function _3_(_, opts)
  local _let_4_ = require("nvim-treesitter.configs")
  local setup = _let_4_["setup"]
  local _5_
  do
    local tbl_17_auto = {}
    local i_18_auto = #tbl_17_auto
    for k, v in pairs(opts.binh_ensure_installed) do
      local val_19_auto
      if v then
        val_19_auto = k
      else
        val_19_auto = nil
      end
      if (nil ~= val_19_auto) then
        i_18_auto = (i_18_auto + 1)
        do end (tbl_17_auto)[i_18_auto] = val_19_auto
      else
      end
    end
    _5_ = tbl_17_auto
  end
  opts["ensure_installed"] = _5_
  opts["binh_ensure_installed"] = nil
  opts["textobjects"] = nil
  return setup(opts)
end
return {init = _1_, opts = _2_, config = _3_}
