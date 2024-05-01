{1 :echasnovski/mini.starter
 :version false
 :event :VimEnter
 :opts (fn []
         (macro new-section [name action section]
           (var pad (string.rep " " 16))
           `{:name ,name :action ,action :section ,(.. pad section)})
         (let [logo (table.concat ["oooooooooo  o88               oooo     ooooo  oooo o88                 "
                                   " 888    888 oooo  oo oooooo    888ooooo 888    88  oooo  oo ooo oooo   "
                                   " 888oooo88   888   888   888   888   888 888  88    888   888 888 888  "
                                   " 888    888  888   888   888   888   888  88888     888   888 888 888  "
                                   "o888ooo888  o888o o888o o888o o888o o888o  888     o888o o888o888o888o "]
                                  "\n")
               pad (string.rep " " 16)
               starter (require :mini.starter)
               opts {:evaluate_single true
                     :header logo
                     :items [(new-section "Find file" "Telescope find_files"
                                          :Telescope)
                             (new-section "Recent files"
                                          "Telescope oldfiles only_cwd=true"
                                          :Telescope)
                             (new-section "Grep text" "Telescope live_grep"
                                          :Telescope)
                             (new-section :Lazy :Lazy :Config)
                             (new-section "New file" "ene | startinsert"
                                          :Built-in)
                             (new-section :Quit :qa :Built-in)
                             (new-section "Session restore"
                                          "lua require('binhvim').open_workspace_recent()"
                                          :Session)]
                     :content_hooks [(starter.gen_hook.adding_bullet (.. pad
                                                                         "░ ")
                                                                     false)
                                     (starter.gen_hook.aligning :center :center)]}]
           opts))
 :config (fn [_ opts]
           ;; close Lazy and re-open when starter is ready
           (when (= vim.o.filetype :lazy)
             (vim.cmd.close)
             (vim.api.nvim_create_autocmd :User
                                          {:pattern :MiniStarterOpened
                                           :callback #((. (require :lazy) :show))}))
           (let [starter (require :mini.starter)
                 load-footer (fn []
                               (let [lazy (require :lazy)
                                     stats (lazy.stats)
                                     ms (-> (* stats.startuptime 100)
                                            (+ 0.5)
                                            (math.floor)
                                            (/ 100))
                                     pad-footer (string.rep " " 8)]
                                 (set starter.config.footer
                                      (.. pad-footer "⚡ Neovim loaded "
                                          stats.loaded "/" stats.count
                                          " plugins in " ms :ms))
                                 (pcall starter.refresh)))]
             (starter.setup opts)
             (vim.api.nvim_create_autocmd :User
                                          {:pattern :LazyVimStarted
                                           :callback load-footer})))}

