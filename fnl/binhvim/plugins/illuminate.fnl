(import-macros {: autocmd} :binhvim.macros)

(macro map [key direct buffer]
  (let [illuminate `(require :illuminate)
        illuminate_key (.. :goto_ direct :_reference)
        illuminate_func `#((. ,illuminate ,illuminate_key) false)
        desc (.. (: (direct:sub 1 1) :upper) (direct:sub 2) " Reference")]
    `(vim.keymap.set :n ,key ,illuminate_func ,{: desc : buffer})))

;; Automatically highlights other instances of the word under your cursor.
;; This works with LSP, Treesitter, and regexp matching to find the other
;; instances.
{1 :RRethy/vim-illuminate
 :event :LazyFile
 :keys [{1 "]]" :desc "Next Reference"} {1 "[[" :desc "Prev Reference"}]
 :opts {:delay 300
        :large_file_cutoff 2000
        :large_file_overrides {:providers [:lsp]}}
 :config (fn []
           (let [illuminate (require :illuminate)]
             (map "]]" :next)
             (map "[[" :prev)
             ;; also set it after loading ftplugins, since a lot overwrite [[ and ]]
             (autocmd :FileType
                      {:group :illuminate_mapping
                       :callback (fn []
                                   (let [buffer (vim.api.nvim_get_current_buf)]
                                     (map "]]" :next buffer)
                                     (map "[[" :prev buffer)))})))}

