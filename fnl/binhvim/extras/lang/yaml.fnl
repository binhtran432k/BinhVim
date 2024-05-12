[;; add yaml to treesitter
 {1 :nvim-treesitter/nvim-treesitter
  :opts {:binh_ensure_installed {:yaml true}}}
 ;; json schema support
 {1 :b0o/SchemaStore.nvim :lazy true :version false}
 ;; correctly setup lspconfig
 {1 :neovim/nvim-lspconfig
  :opts {:servers {:yamlls {;; Have to add this for yamlls to understand that we support line folding
                            :capabilities {:textDocument {:foldingRange {:dynamicRegistration false
                                                                         :lineFoldingOnly true}}}
                            ;; lazy-load schemastore when needed
                            :on_new_config (fn [new_config]
                                             (set new_config.settings.yaml.schemas
                                                  (or new_config.settings.yaml.schemas
                                                      []))
                                             (vim.list_extend new_config.settings.yaml.schemas
                                                              ((. (. (require :schemastore)
                                                                     :yaml)
                                                                  :schemas))))
                            :settings {:yaml {:keyOrdering false
                                              :format {:enable true}
                                              :validate true
                                              :schemaStore {;; Must disable builtin-in schemaStore support to use
                                                            ;; schemas from SchemaStore.nvim plugin
                                                            :enable false
                                                            ;; Avoid TypeError: Cannot read properties of undefinded (reading 'length')
                                                            :url ""}}}}}
         :setup {:yamlls (fn [_ _ add-on-attach]
                           ;; Neovim < 0.10 does not have dynamic registration for formatting
                           (when (= (vim.fn.has :nvim-0.10) 0)
                             (add-on-attach (fn [client _]
                                              (when (= client.name :yamlls)
                                                (set client.server_capabilities.documentFormattingProvider
                                                     true))))))}}}]

