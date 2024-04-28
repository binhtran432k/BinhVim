(import-macros {: autocmd} :binhvim.macros)

(macro load [pname]
  `(do
     ((. (require ,(.. :binhvim.config. pname)) :setup))
     (pcall require ,(.. :config. pname))))

(fn init []
  ;; load options here, before lazy init while sourcing plugin modules
  ;; this is needed to make sure options will be correctly applied
  ;; after installing missing plugins
  (load :options))

(fn setup [opts]
  (let [;; autocmds can be loaded lazily when not opening a file
        lazy-autocmds? (= (vim.fn.argc -1) 0)]
    (when opts.colorscheme
      (pcall vim.cmd (.. "colorscheme " opts.colorscheme)))
    (when (not lazy-autocmds?)
      (load :autocmds))
    (autocmd :User {:group :BinhVim
                    :pattern :VeryLazy
                    :callback (fn []
                                (when lazy-autocmds?
                                  (load :autocmds))
                                (load :keymaps))})))

{: init : setup}

