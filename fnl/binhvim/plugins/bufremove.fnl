;; buffer remove
{1 :echasnovski/mini.bufremove
 :keys [{1 :<leader>bd
         2 (fn []
             (let [bufremove (require :mini.bufremove)
                   bd bufremove.delete]
               (if vim.bo.modified
                   (let [msg (: "Save changes to %q?" :format (vim.fn.bufname))
                         choice (vim.fn.confirm msg "&Yes\n&No\n&Cancel")]
                     (if ;; yes
                         (= choice 1) (do
                                        (vim.cmd.write)
                                        (bd 0))
                         ;; no
                         (= choice 2) (bd 0 true)))
                   (bd 0))))
         :desc "Delete Buffer"}
        {1 :<leader>bD
         2 #((. (require :mini.bufremove) :delete) 0 true)
         :desc "Delete Buffer (Force)"}]}

