-- [nfnl] Compiled from fnl/binhvim/config/plugins/todo_comments.fnl by https://github.com/Olical/nfnl, do not edit.
local function keys()
  local function _1_()
    return (require("todo-comments")).jump_next()
  end
  local function _2_()
    return (require("todo-comments")).jump_prev()
  end
  return {{"]t", _1_, desc = "Next Todo Comment"}, {"[t", _2_, desc = "Previous Todo Comment"}, {"<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)"}, {"<leader>xT", "<cmd>TodoTrouble keywords=TODOFIXFIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)"}, {"<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo"}, {"<leader>sT", "<cmd>TodoTelescope keywords=TODOFIXFIXME<cr>", desc = "Todo/Fix/Fixme"}}
end
return {keys = keys}
