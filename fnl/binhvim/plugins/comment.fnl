;; comments
[{1 :JoosepAlviste/nvim-ts-context-commentstring
  :lazy true
  :opts {:enable_autocmd false}}
 {1 :numToStr/Comment.nvim
  :keys [{1 :gc :desc "+comment line" :mode [:n :x]}
         {1 :gb :desc "+comment block" :mode [:n :x]}]
  :opts (fn []
          {:pre_hook ((. (require :ts_context_commentstring.integrations.comment_nvim)
                         :create_pre_hook))})}]

