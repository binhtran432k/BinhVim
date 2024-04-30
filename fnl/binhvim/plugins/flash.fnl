;; Flash enhances the built-in search functionality by showing labels
;; at the end of each match, letting you quickly jump to a specific
;; location.
{1 :folke/flash.nvim
 :event :VeryLazy
 :vscode true
 :opts {}
 :keys [{1 :s 2 #((. (require :flash) :jump)) :mode [:n :x :o] :desc :Flash}
        {1 :S
         2 #((. (require :flash) :treesitter))
         :mode [:n :o :x]
         :desc "Flash Treesitter"}
        {1 :r 2 #((. (require :flash) :remote)) :mode :o :desc "Remote Flash"}
        {1 :R
         2 #((. (require :flash) :treesitter_search))
         :mode [:o :x]
         :desc "Treesitter Search"}
        {1 :<c-s>
         2 #((. (require :flash) :toggle))
         :mode [:c]
         :desc "Toggle Flash Search"}]}

