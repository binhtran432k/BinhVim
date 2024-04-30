(import-macros {: autocmd} :binhvim.macros)

(macro map [key direct buffer]
  (let [illuminate `(require :illuminate)
        illuminate_key (.. :goto_ direct :_reference)
        illuminate_func `#((. ,illuminate ,illuminate_key) false)
        desc (.. (: (direct:sub 1 1) :upper) (direct:sub 2) " Reference")]
    `(vim.keymap.set :n ,key ,illuminate_func ,{: desc : buffer})))

(fn opts []
  {:delay 300
   :large_file_cutoff 2000
   :large_file_overrides {:providers [:lsp]}})

(fn config []
  (let [illuminate (require :illuminate)]
    (map "]]" :next)
    (map "[[" :prev)
    ;; also set it after loading ftplugins, since a lot overwrite [[ and ]]
    (autocmd :FileType
             {:group :illuminate_mapping
              :callback (fn []
                          (let [buffer (vim.api.nvim_get_current_buf)]
                            (map "]]" :next buffer)
                            (map "[[" :prev buffer)))})))

{: opts : config}

