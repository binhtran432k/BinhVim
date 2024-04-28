-- [nfnl] Compiled from fnl/binhvim/config/plugins/ai.fnl by https://github.com/Olical/nfnl, do not edit.
local function opts()
  local ai = require("mini.ai")
  local ai_open = ai.gen_spec.treesitter({a = {"@block.outer", "@conditional.outer", "@loop.outer"}, i = {"@block.inner", "@conditional.inner", "@loop.inner"}}, {})
  local ai_func = ai.gen_spec.treesitter({a = "@function.outer", i = "@function.inner"}, {})
  local ai_cls = ai.gen_spec.treesitter({a = "@class.outer", i = "@class.inner"}, {})
  local ai_tag = {"<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$"}
  local ai_digit = {"%f[%d]%d+"}
  local ai_word = {{"%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]"}, "^().*()$"}
  local ai_global
  local function _1_()
    local from = {line = 1, col = 1}
    local to = {line = vim.fn.line("$"), col = math.max(vim.fn.getline("$"):len(), 1)}
    return {from = from, to = to}
  end
  ai_global = _1_
  local ai_usage = ai.gen_spec.function_call()
  local ai_usage_nodot = ai.gen_spec.function_call({name_pattern = "[%w_]"})
  return {n_lines = 500, custom_textobjects = {o = ai_open, f = ai_func, c = ai_cls, t = ai_tag, d = ai_digit, e = ai_word, g = ai_global, u = ai_usage, U = ai_usage_nodot}}
end
local function config(_, opts0)
  local _let_2_ = require("mini.ai")
  local setup = _let_2_["setup"]
  return setup(opts0)
end
local function wk_opts(_, opts0)
  local i = {[" "] = "Whitespace", ["\""] = "Balanced \"", ["'"] = "Balanced '", ["`"] = "Balanced `", ["("] = "Balanced (", [")"] = "Balanced ) including white-space", [">"] = "Balanced > including white-space", ["<lt>"] = "Balanced <", ["]"] = "Balanced ] including white-space", ["["] = "Balanced [", ["}"] = "Balanced } including white-space", ["{"] = "Balanced {", ["?"] = "User Prompt", _ = "Underscore", a = "Argument", b = "Balanced ), ], }", c = "Class", d = "Digit(s)", e = "Word in CamelCase & snake_case", f = "Function", g = "Entire file", o = "Block, conditional, loop", q = "Quote `, \", '", t = "Tag", u = "Use/call function & method", U = "Use/call without dot in name"}
  local a
  do
    local tbl_14_auto = {}
    for k, v in pairs(i) do
      local k_15_auto, v_16_auto = k, v:gsub(" including.*", "")
      if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
        tbl_14_auto[k_15_auto] = v_16_auto
      else
      end
    end
    a = tbl_14_auto
  end
  local ic = vim.deepcopy(i)
  local ac = vim.deepcopy(a)
  do
    do
      i["l"] = vim.tbl_extend("force", {name = "Inside Last textobject"}, ic)
      do end (a)["l"] = vim.tbl_extend("force", {name = "Around Last textobject"}, ac)
    end
    i["n"] = vim.tbl_extend("force", {name = "Inside Next textobject"}, ic)
    do end (a)["n"] = vim.tbl_extend("force", {name = "Around Next textobject"}, ac)
  end
  local new_opts = {binh_register = {ai = {mode = {"o", "x"}, i = i, a = a}}}
  return vim.tbl_deep_extend("force", opts0, new_opts)
end
return {opts = opts, config = config, wk_opts = wk_opts}
