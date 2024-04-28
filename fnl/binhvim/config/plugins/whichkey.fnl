(fn opts [_ opts]
  (let [defaults {:mode [:n :v]
                  :g {:name :+goto}
                  :gs {:name :+surround}
                  :z {:name :+fold}
                  "[" {:name :+next}
                  "]" {:name :+prev}
                  :<leader><tab> {:name :+tabs}
                  :<leader>b {:name :+buffer}
                  :<leader>c {:name :+code}
                  :<leader>f {:name :+file/find}
                  :<leader>g {:name :+git}
                  :<leader>gh {:name :+hunks}
                  :<leader>q {:name :+quit/session}
                  :<leader>s {:name :+search}
                  :<leader>u {:name :+ui}
                  :<leader>w {:name :+windows}
                  :<leader>x {:name :+diagnostics/quickfix}}
        new-opts {:plugins {:spelling true} :binh_register {: defaults}}]
    (vim.tbl_deep_extend :force opts new-opts)))

(fn config [_ opts]
  (let [wk (require :which-key)]
    (wk.setup opts)
    (each [_ wk-reg (pairs opts.binh_register)]
      (wk.register wk-reg))))

{: opts : config}

