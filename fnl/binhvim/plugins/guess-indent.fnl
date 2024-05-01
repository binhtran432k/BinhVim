{1 :nmac427/guess-indent.nvim
 :event [:BufReadPost :BufNewFile]
 :opts {;; Set to false to disable automatic execution
        :auto_cmd true
        ;; Set to true to override settings set by .editorconfig
        :override_editorconfig false
        ;; A list of filetypes for which the auto command gets disabled
        :filetype_exclude [:netrw :tutor :cobol]
        ;; A list of buffer types for which the auto command gets disabled
        :buftype_exclude [:help :nofile :terminal :prompt :cobol]}}

