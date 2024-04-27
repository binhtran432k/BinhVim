{:init (fn [plugin]
         ;; PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
         ;; This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
         ;; no longer trigger the **nvim-treesitter** module to be loaded in time.
         ;; Luckily, the only things that those plugins need are the custom queries, which we make available
         ;; during startup.
         ((. (require :lazy.core.loader) :add_to_rtp) plugin)
         (require :nvim-treesitter.query_predicates))
 :opts #{:highlight {:enable true}
         :indent {:enable true}
         :ensure_installed []
         :binh_ensure_installed {:bash true
                                 :c true
                                 :diff true
                                 :fennel true
                                 :html true
                                 :javascript true
                                 :jsdoc true
                                 :json true
                                 :jsonc true
                                 :lua true
                                 :luadoc true
                                 :luap true
                                 :markdown true
                                 :markdown_inline true
                                 :python true
                                 :query true
                                 :regex true
                                 :toml true
                                 :tsx true
                                 :typescript true
                                 :vim true
                                 :vimdoc true
                                 :xml true
                                 :yaml true}
         :incremental_selection {:enable true
                                 :keymaps {:init_selection :<c-space>
                                           :node_incremental :<c-space>
                                           :scope_incremental false
                                           :node_decremental :<bs>}}
         :textobjects {:move {:enable true
                              :goto_next_start {"]f" "@function.outer"
                                                "]c" "@class.outer"}
                              :goto_next_end {"]F" "@function.outer"
                                              "]C" "@class.outer"}
                              :goto_previous_start {"[f" "@function.outer"
                                                    "[c" "@class.outer"}
                              :goto_previous_end {"[F" "@function.outer"
                                                  "[C" "@class.outer"}}}}
 :config (fn [_ opts]
           (let [{: setup} (require :nvim-treesitter.configs)]
             (tset opts :ensure_installed
                   (icollect [k v (pairs opts.binh_ensure_installed)]
                     (when v k)))
             (tset opts :binh_ensure_installed nil)
             (setup opts)))}

