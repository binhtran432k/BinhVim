-- [nfnl] Compiled from fnl/binhvim/plugins/autopairs.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_(_, plug_opts)
  local npairs = require("nvim-autopairs")
  local Rule = require("nvim-autopairs.rule")
  local cond = require("nvim-autopairs.conds")
  local brackets = {{"(", ")"}, {"[", "]"}, {"{", "}"}}
  local space_rule
  local function _2_(opts)
    local ctx = (opts.line):sub((opts.col - 1), opts.col)
    local _3_
    do
      local tbl_17_auto = {}
      local i_18_auto = #tbl_17_auto
      for _0, _4_ in ipairs(brackets) do
        local _each_5_ = _4_
        local left = _each_5_[1]
        local right = _each_5_[2]
        local val_19_auto = (left .. right)
        if (nil ~= val_19_auto) then
          i_18_auto = (i_18_auto + 1)
          do end (tbl_17_auto)[i_18_auto] = val_19_auto
        else
        end
      end
      _3_ = tbl_17_auto
    end
    return vim.tbl_contains(_3_, ctx)
  end
  local function _7_(opts)
    local col = (vim.api.nvim_win_get_cursor(0))[2]
    local ctx = (opts.line):sub((col - 1), (col + 2))
    local _8_
    do
      local tbl_17_auto = {}
      local i_18_auto = #tbl_17_auto
      for _0, _9_ in ipairs(brackets) do
        local _each_10_ = _9_
        local left = _each_10_[1]
        local right = _each_10_[2]
        local val_19_auto = (left .. " " .. right)
        if (nil ~= val_19_auto) then
          i_18_auto = (i_18_auto + 1)
          do end (tbl_17_auto)[i_18_auto] = val_19_auto
        else
        end
      end
      _8_ = tbl_17_auto
    end
    return vim.tbl_contains(_8_, ctx)
  end
  space_rule = Rule(" ", " "):with_pair(_2_):with_move(cond.none()):with_cr(cond.none()):with_del(_7_)
  npairs.setup(plug_opts)
  npairs.add_rules({space_rule})
  for _0, _12_ in ipairs(brackets) do
    local _each_13_ = _12_
    local _1 = _each_13_[1]
    local right = _each_13_[2]
    local function _14_(_241)
      return (_241.char == right)
    end
    Rule("", (" " .. right)):with_pair(cond.none()):with_move(_14_):with_cr(cond.none()):with_del(cond.none()):use_key(right)
  end
  return nil
end
return {"windwp/nvim-autopairs", event = "InsertEnter", dependencies = {"nvim-treesitter/nvim-treesitter", opts = {autopairs = {enable = true}}}, opts = {fast_wrap = {}, enable_check_bracket_line = false}, config = _1_}
