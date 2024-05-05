[{1 :neovim/nvim-lspconfig
  :opts {:servers {:tailwindcss {;; exclude a filetype from the default_config
                                 :filetypes_exclude {:markdown true}
                                 ;; add additional filetypes to the default_config
                                 :filetypes_include {}
                                 ;; to fully override the default_config, change the below
                                 ;; :filetypes {}
                                 }
                   :biome {}
                   :cssls {}
                   :html {}
                   :emmet_language_server {}}
         :setup {:tailwindcss (fn [_ opts]
                                (let [tw (require :lspconfig.server_configurations.tailwindcss)
                                      filetypes (or opts.filetypes
                                                    (collect [_ ft (ipairs tw.default_config.filetypes)]
                                                      (values ft true)))]
                                  ;; Add additional filetypes
                                  (each [ft enable (pairs opts.filetypes_include)]
                                    (when enable (tset filetypes ft true)))
                                  ;; Remove excluded filetypes
                                  (each [ft enable (pairs opts.filetypes_exclude)]
                                    (when enable (tset filetypes ft false)))
                                  (set opts.filetypes
                                       (icollect [ft enable (pairs filetypes)]
                                         (if enable ft nil)))
                                  false))}}}
 {1 :nvim-treesitter/nvim-treesitter
  :opts {:binh_ensure_installed {:css true :scss true}}}
 {1 :hrsh7th/nvim-cmp
  :dependencies {1 :roobert/tailwindcss-colorizer-cmp.nvim :config true}
  :opts (fn [_ opts]
          (let [format-kinds opts.formatting.format]
            (set opts.formatting.format
                 (fn [entry item]
                   (format-kinds entry item)
                   ((. (require :tailwindcss-colorizer-cmp) :formatter) entry
                                                                        item)))))}]

