;; file explorer
{1 :nvim-tree/nvim-tree.lua
 :version "*"
 :keys [{1 :<leader>e 2 :<cmd>NvimTreeToggle<cr> :desc :Explorer}
        {1 :<leader>fe
         2 :<cmd>NvimTreeFindFileToggle<cr>
         :desc "Explorer Focus File"}
        {1 :<leader>fE
         2 "<cmd>NvimTreeToggle %:p:h<cr>"
         :desc "Explorer Parent Directory"}
        {1 :<leader>fp
         2 "<cmd>NvimTreeToggle $PWD<cr>"
         :desc "Explorer PWD"}
         ]
 :cmd [:NvimTreeToggle :NvimTreeFocus :NvimTreeFindFile :NvimTreeCollapse]
 :opts {}
 :config #((. (require :nvim-tree) :setup) $2)}

