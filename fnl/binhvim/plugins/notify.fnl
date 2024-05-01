(import-macros {: autocmd} :binhvim.macros)

;; Better `vim.notify()`
{1 :rcarriga/nvim-notify
 :keys [{1 :<leader>un
         2 #((. (require :notify) :dismiss) {:silent true :pending true})
         :desc "Dismiss All Notifications"}]
 :opts {:stages :static
        :timeout 3000
        :max_height #(math.floor (* vim.o.lines 0.75))
        :max_width #(math.floor (* vim.o.columns 0.75))
        :on_open #(vim.api.nvim_win_set_config $1 {:zindex 100})}
 :init (fn []
         ;; when noice is not enabled, install notify on VeryLazy
         (autocmd :User
                  {:pattern :VeryLazy
                   :callback #(set vim.notify (require :notify))}))}

