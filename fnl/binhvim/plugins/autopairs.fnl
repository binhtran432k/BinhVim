;; auto pairs
{1 :windwp/nvim-autopairs
 :event :InsertEnter
 :dependencies {1 :nvim-treesitter/nvim-treesitter
                :opts {:autopairs {:enable true}}}
 :opts {:fast_wrap {} :enable_check_bracket_line false}
 :config (fn [_ plug-opts]
           (let [npairs (require :nvim-autopairs)
                 Rule (require :nvim-autopairs.rule)
                 cond (require :nvim-autopairs.conds)
                 brackets [["(" ")"] ["[" "]"] ["{" "}"]]
                 space-rule (-> (Rule " " " ")
                                (: :with_pair
                                   (fn [opts]
                                     (let [ctx (opts.line:sub (- opts.col 1)
                                                              opts.col)]
                                       (vim.tbl_contains (icollect [_ [left
                                                                       right] (ipairs brackets)]
                                                           (.. left right))
                                                         ctx))))
                                (: :with_move (cond.none))
                                (: :with_cr (cond.none))
                                (: :with_del
                                   (fn [opts]
                                     (let [col (. (vim.api.nvim_win_get_cursor 0)
                                                  2)
                                           ctx (opts.line:sub (- col 1)
                                                              (+ col 2))]
                                       (vim.tbl_contains (icollect [_ [left
                                                                       right] (ipairs brackets)]
                                                           (.. left " " right))
                                                         ctx)))))]
             (npairs.setup plug-opts)
             ;; auto add space
             (npairs.add_rules [space-rule])
             (each [_ [_ right] (ipairs brackets)]
               (-> (Rule "" (.. " " right))
                   (: :with_pair (cond.none))
                   (: :with_move #(= $1.char right))
                   (: :with_cr (cond.none))
                   (: :with_del (cond.none))
                   (: :use_key right)))))}

