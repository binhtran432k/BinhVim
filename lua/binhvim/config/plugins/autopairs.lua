-- [nfnl] Compiled from fnl/binhvim/config/plugins/autopairs.fnl by https://github.com/Olical/nfnl, do not edit.
local function opts()
  return {fast_wrap = {}}
end
local function config(_, plug_opts)
  local npairs = require("nvim-autopairs")
  local Rule = require("nvim-autopairs.rule")
  local cond = require("nvim-autopairs.conds")
  local brackets = {{"(", ")"}, {"[", "]"}, {"{", "}"}}
  npairs.setup(plug_opts)
  local function _1_(opts0)
    local ctx = (opts0.line):sub((opts0.col - 1), opts0.col)
    local _2_
    do
      local tbl_17_auto = {}
      local i_18_auto = #tbl_17_auto
      for _0, _3_ in ipairs(brackets) do
        local _each_4_ = _3_
        local left = _each_4_[1]
        local right = _each_4_[2]
        local val_19_auto = (left .. right)
        if (nil ~= val_19_auto) then
          i_18_auto = (i_18_auto + 1)
          do end (tbl_17_auto)[i_18_auto] = val_19_auto
        else
        end
      end
      _2_ = tbl_17_auto
    end
    return vim.tbl_contains(_2_, ctx)
  end
  local function _6_(opts0)
    local col = (vim.api.nvim_win_get_cursor(0))[2]
    local ctx = (opts0.line):sub((col - 1), (col + 2))
    local _7_
    do
      local tbl_17_auto = {}
      local i_18_auto = #tbl_17_auto
      for _0, _8_ in ipairs(brackets) do
        local _each_9_ = _8_
        local left = _each_9_[1]
        local right = _each_9_[2]
        local val_19_auto = (left .. " " .. right)
        if (nil ~= val_19_auto) then
          i_18_auto = (i_18_auto + 1)
          do end (tbl_17_auto)[i_18_auto] = val_19_auto
        else
        end
      end
      _7_ = tbl_17_auto
    end
    return vim.tbl_contains(_7_, ctx)
  end
  npairs.add_rules({Rule(" ", " "):with_pair(_1_):with_move(cond.none()):with_cr(cond.none()):with_del(_6_)})
  for _0, _11_ in ipairs(brackets) do
    local _each_12_ = _11_
    local _1 = _each_12_[1]
    local right = _each_12_[2]
    local function _13_(_241)
      return (_241.char == right)
    end
    Rule("", (" " .. right)):with_pair(cond.none()):with_move(_13_):with_cr(cond.none()):with_del(cond.none()):use_key(right)
  end
  return nil
end
return {opts = opts, config = config}
