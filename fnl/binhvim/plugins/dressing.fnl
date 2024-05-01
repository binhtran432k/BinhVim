;; better vim.ui
(macro override [cmd]
  (let [lazy-load `(. (require :lazy) :load)]
    `(set ,cmd (fn [...]
                 (,lazy-load {:plugins [:dressing.nvim]})
                 (,cmd ...)))))

{1 :stevearc/dressing.nvim
 :lazy true
 :opts {:input {:insert_only false}}
 :init (fn []
         (override vim.ui.select)
         (override vim.ui.input))}

