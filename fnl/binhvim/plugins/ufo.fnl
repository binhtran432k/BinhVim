{1 :kevinhwang91/nvim-ufo
 :event :LazyFile
 :dependencies :kevinhwang91/promise-async
 :keys [{1 :zR
         2 #((. (require :ufo) :openAllFolds) $...)
         :desc "Open all folds"}
        {1 :zM
         2 #((. (require :ufo) :closeAllFolds) $...)
         :desc "Close all folds"}]
 :init (fn []
         (set vim.o.foldcolumn :1)
         (set vim.o.foldlevel 99)
         (set vim.o.foldlevelstart 99)
         (set vim.o.foldenable true))
 :opts {:provider_selector #[:treesitter :indent]}}

