;; [nfnl-macro]

(fn autocmd [event {: group : callback : desc : pattern}]
  `(vim.api.nvim_create_autocmd ,event
                                {:group ,(and group
                                              `(vim.api.nvim_create_augroup ,(.. :binhvim_
                                                                                 group)
                                                                            {:clear true}))
                                 :callback ,callback
                                 :desc ,desc
                                 :pattern ,pattern}))

{: autocmd}

