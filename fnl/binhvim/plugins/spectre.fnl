;; search/replace in multiple files
{1 :nvim-pack/nvim-spectre
 :build false
 :cmd :Spectre
 :opts {:open_cmd "noswapfile vnew"}
 :keys [{1 :<leader>sr
         2 #((. (require :spectre) :open))
         :desc "Replace in Files (Spectre)"}]}

