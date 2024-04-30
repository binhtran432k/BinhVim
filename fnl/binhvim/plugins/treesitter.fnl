[;;; Treesitter
 ;; treesitter is a new parser generator tool that we can
 ;; use in Neovim to power faster and more accurate
 ;; syntax highlighting.
 {1 :nvim-treesitter/nvim-treesitter
  :version false
  :dependencies [{1 :nvim-treesitter/nvim-treesitter-textobjects
                  :config (fn []
                            ;; When in diff mode, we want to use the default
                            ;; vim text objects c & C instead of the treesitter ones.
                            (let [move (require :nvim-treesitter.textobjects.move)
                                  configs (require :nvim-treesitter.configs)]
                              (each [name fun (pairs move)]
                                (when (= (name:find :goto) 1)
                                  (tset move name
                                        (fn [q ...]
                                          (if vim.wo.diff
                                              (let [get-module (. configs
                                                                  :get_module)
                                                    move-module (get-module :textobjects.move)
                                                    config (or (. move-module
                                                                  name)
                                                               {})]
                                                (each [key query (pairs config)]
                                                  (when (and (= q query)
                                                             (key:find "[%]%[][cC]"))
                                                    (vim.cmd (.. "normal! " key))
                                                    (lua :return))))
                                              (fun q ...))))))))}
                 {1 :HiPhish/rainbow-delimiters.nvim}]
  :event [:LazyFile :VeryLazy]
  :cmd [:TSInstall
        :TSBufEnable
        :TSBufDisable
        :TSModuleInfo
        :TSUninstall
        :TSUpdate]
  :keys [{1 :<c-space> :desc "Increment Selection"}
         {1 :<bs> :desc "Decrement Selection" :mode :x}]
  :build ":TSUpdate"
  :init (fn [plugin]
          ;; PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
          ;; This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
          ;; no longer trigger the **nvim-treesitter** module to be loaded in time.
          ;; Luckily, the only things that those plugins need are the custom queries, which we make available
          ;; during startup.
          ((. (require :lazy.core.loader) :add_to_rtp) plugin)
          (require :nvim-treesitter.query_predicates))
  :opts {:highlight {:enable true}
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
 ;; automatically add closing tags for HTML and JSX
 {1 :windwp/nvim-ts-autotag
  :event :LazyFile
  :ft [:html :javascript :jsx :typescript :tsx :svelte :vue :xml :markdown]
  :opts {}}]

