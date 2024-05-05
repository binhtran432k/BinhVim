[;; add json to treesitter
 {1 :nvim-treesitter/nvim-treesitter
  :opts {:binh_ensure_installed {:json true :json5 true :jsonc true}}}
 ;; json schema support
 {1 :b0o/SchemaStore.nvim :lazy true :version false}
 ;; correctly setup lspconfig
 {1 :neovim/nvim-lspconfig
  :opts {;; make sure mason installs the server
         :servers {:jsonls {;; lazy-load schemastore when needed
                            :on_new_config (fn [new_config]
                                             (set new_config.settings.json.schemas
                                                  (or new_config.settings.json.schemas
                                                      []))
                                             (vim.list_extend new_config.settings.json.schemas
                                                              ((. (. (require :schemastore)
                                                                     :json)
                                                                  :schemas))))
                            :settings {:json {:format {:enable true}
                                              :validate {:enable true}}}}}}}]

