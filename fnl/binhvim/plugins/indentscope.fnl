;; Active indent guide and indent text objects. When you're browsing
;; code, this highlights the current level of indentation, and animates
;; the highlighting.
{1 :echasnovski/mini.indentscope
 :version false
 :event :LazyFile
 :opts (fn [_ opts]
         (let [indentscope (require :mini.indentscope)
               none-animation (indentscope.gen_animation.none)]
           (vim.tbl_deep_extend :force opts
                                {:symbol "│"
                                 :options {:try_as_border true}
                                 :draw {:delay 300 :animation none-animation}})))
 :init (fn []
         (vim.api.nvim_create_autocmd :FileType
                                      {:pattern [:help
                                                 :alpha
                                                 :dashboard
                                                 :neo-tree
                                                 :Trouble
                                                 :trouble
                                                 :lazy
                                                 :mason
                                                 :notify
                                                 :toggleterm
                                                 :lazyterm]
                                       :callback #(set vim.b.miniindentscope_disable
                                                       true)}))}

