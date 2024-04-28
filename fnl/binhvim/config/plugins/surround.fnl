(fn keys [_ keys]
  ;; Populate the keys based on the user's options
  (let [lazy-config (require :lazy.core.config)
        plugin (. lazy-config.spec.plugins :mini.surround)
        lazy-plugin (require :lazy.core.plugin)
        opts (lazy-plugin.values plugin :opts false)
        mappings [{1 opts.mappings.add :desc "Add Surrounding" :mode {:n :v}}
                  {1 opts.mappings.delete :desc "Delete Surrounding"}
                  {1 opts.mappings.find :desc "Find Right Surrounding"}
                  {1 opts.mappings.find_left :desc "Find Left Surrounding"}
                  {1 opts.mappings.highlight :desc "Highlight Surrounding"}
                  {1 opts.mappings.replace :desc "Replace Surrounding"}
                  {1 opts.mappings.update_n_lines
                   :desc "Update `MiniSurround.config.n_lines`"}]
        mappings (vim.tbl_filter #(and (. $1 1) (< 0 (length (. $1 1))))
                                 mappings)]
    (vim.list_extend mappings keys)))

(fn opts []
  {:mappings {;; Add surrounding in Normal and Visual modes
              :add :gsa
              ;; Delete surrounding
              :delete :gsd
              ;; Find surrounding (to the right)
              :find :gsf
              ;; Find surrounding (to the left)
              :find_left :gsF
              ;; Highlight surrounding
              :highlight :gsh
              ;; Replace surrounding
              :replace :gsr
              ;; Update `n_lines`
              :update_n_lines :gsn}})

{: opts : keys}

