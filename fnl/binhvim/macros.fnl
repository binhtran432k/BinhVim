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

(fn run-in-directory? [cmd]
  `(when (= (vim.fn.argc -1) 1)
     (let [stat# (vim.uv.fs_stat (vim.fn.argv 0))]
       (when (and stat# (= stat#.type :directory))
         ,cmd))))

(fn get-lazy-opts [pname]
  `(let [lazy-config# (require :lazy.core.config)
         plugin# (. lazy-config#.spec.plugins ,pname)
         lazy-plugin# (require :lazy.core.plugin)
         opts# (lazy-plugin#.values plugin# :opts false)]
     opts#))

{: autocmd : run-in-directory? : get-lazy-opts}

