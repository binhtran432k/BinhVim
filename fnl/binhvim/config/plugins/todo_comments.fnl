(fn keys []
  [{1 "]t"
    2 #((. (require :todo-comments) :jump_next))
    :desc "Next Todo Comment"}
   {1 "[t"
    2 #((. (require :todo-comments) :jump_prev))
    :desc "Previous Todo Comment"}
   {1 :<leader>xt 2 :<cmd>TodoTrouble<cr> :desc "Todo (Trouble)"}
   {1 :<leader>xT
    2 "<cmd>TodoTrouble keywords=TODOFIXFIXME<cr>"
    :desc "Todo/Fix/Fixme (Trouble)"}
   {1 :<leader>st 2 :<cmd>TodoTelescope<cr> :desc :Todo}
   {1 :<leader>sT
    2 "<cmd>TodoTelescope keywords=TODOFIXFIXME<cr>"
    :desc :Todo/Fix/Fixme}])

{: keys}

