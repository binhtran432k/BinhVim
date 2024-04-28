-- [nfnl] Compiled from fnl/binhvim/config/plugins/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local function init(plugin)
  do end (require("lazy.core.loader")).add_to_rtp(plugin)
  return require("nvim-treesitter.query_predicates")
end
local function opts()
  return {highlight = {enable = true}, indent = {enable = true}, ensure_installed = {}, binh_ensure_installed = {bash = true, c = true, diff = true, fennel = true, html = true, javascript = true, jsdoc = true, json = true, jsonc = true, lua = true, luadoc = true, luap = true, markdown = true, markdown_inline = true, python = true, query = true, regex = true, toml = true, tsx = true, typescript = true, vim = true, vimdoc = true, xml = true, yaml = true}, incremental_selection = {enable = true, keymaps = {init_selection = "<c-space>", node_incremental = "<c-space>", node_decremental = "<bs>", scope_incremental = false}}, textobjects = {move = {enable = true, goto_next_start = {["]f"] = "@function.outer", ["]c"] = "@class.outer"}, goto_next_end = {["]F"] = "@function.outer", ["]C"] = "@class.outer"}, goto_previous_start = {["[f"] = "@function.outer", ["[c"] = "@class.outer"}, goto_previous_end = {["[F"] = "@function.outer", ["[C"] = "@class.outer"}}}}
end
local function textobjects_config()
  local move = require("nvim-treesitter.textobjects.move")
  local configs = require("nvim-treesitter.configs")
  for name, fun in pairs(move) do
    if (name:find("goto") == 1) then
      local function _1_(q, ...)
        if vim.wo.diff then
          local get_module = configs.get_module
          local move_module = get_module("textobjects.move")
          local config = (move_module[name] or {})
          for key, query in pairs(config) do
            if ((q == query) and key:find("[%]%[][cC]")) then
              vim.cmd(("normal! " .. key))
              return
            else
            end
          end
          return nil
        else
          return fun(q, ...)
        end
      end
      move[name] = _1_
    else
    end
  end
  return nil
end
local function config(_, opts0)
  local _let_5_ = require("nvim-treesitter.configs")
  local setup = _let_5_["setup"]
  local _6_
  do
    local tbl_17_auto = {}
    local i_18_auto = #tbl_17_auto
    for k, v in pairs(opts0.binh_ensure_installed) do
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
    _6_ = tbl_17_auto
  end
  opts0["ensure_installed"] = _6_
  opts0["binh_ensure_installed"] = nil
  return setup(opts0)
end
return {init = init, opts = opts, config = config, textobjects_config = textobjects_config}
