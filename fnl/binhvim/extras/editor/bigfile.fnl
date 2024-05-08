{1 :LunarVim/bigfile.nvim
 :event [:BufEnter :BufNewFile]
 :opts {;; size of the file in MiB, the plugin round file sizes to the closest MiB
        :filesize 1
        ;; autocmd pattern or function see <### Overriding the detection of big files>
        :pattern ["*"]
        ;; features to disable
        :features [:indent_blankline
                   :illuminate
                   :lsp
                   :treesitter
                   :syntax
                   :matchparen
                   :vimopts
                   :filetype]}}

