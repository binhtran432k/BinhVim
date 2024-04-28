(fn init [plugin]
  ;; PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
  ;; This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
  ;; no longer trigger the **nvim-treesitter** module to be loaded in time.
  ;; Luckily, the only things that those plugins need are the custom queries, which we make available
  ;; during startup.
  ((. (require :lazy.core.loader) :add_to_rtp) plugin)
  (require :nvim-treesitter.query_predicates))

(fn opts []
  {:highlight {:enable true}
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
                                            "[C" "@class.outer"}}}})

(fn textobjects_config []
  ;; When in diff mode, we want to use the default
  ;; vim text objects c & C instead of the treesitter ones.
  (let [move (require :nvim-treesitter.textobjects.move)
        configs (require :nvim-treesitter.configs)]
    (each [name fun (pairs move)]
      (when (= (name:find :goto) 1)
        (tset move name (fn [q ...]
                          (if vim.wo.diff
                              (let [get-module (. configs :get_module)
                                    move-module (get-module :textobjects.move)
                                    config (or (. move-module name) {})]
                                (each [key query (pairs config)]
                                  (when (and (= q query)
                                             (key:find "[%]%[][cC]"))
                                    (vim.cmd (.. "normal! " key))
                                    (lua :return))))
                              (fun q ...))))))))

(fn config [_ opts]
  (let [{: setup} (require :nvim-treesitter.configs)]
    (tset opts :ensure_installed (icollect [k v (pairs opts.binh_ensure_installed)]
                                   (when v k)))
    (tset opts :binh_ensure_installed nil)
    (setup opts)))

{: init : opts : config : textobjects_config}

