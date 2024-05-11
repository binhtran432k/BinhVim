(import-macros {: get-lazy-opts} :binhvim.macros)

[;; Add C/C++ to treesitter
 {1 :nvim-treesitter/nvim-treesitter
  :opts {:binh_ensure_installed {:c true :cpp true}}}
 {1 :p00f/clangd_extensions.nvim
  :lazy true
  :config #nil
  :opts {:inlay_hints {:inline false}
         :ast {;; These require codicons (https://github.com/microsoft/vscode-codicons)
               :role_icons {:type ""
                            :declaration ""
                            :expression ""
                            :specifier ""
                            :statement ""
                            "template argument" ""}
               :kind_icons {:Compound ""
                            :Recovery ""
                            :TranslationUnit ""
                            :PackExpansion ""
                            :TemplateTypeParm ""
                            :TemplateTemplateParm ""
                            :TemplateParamObject ""}}}}
 ;; Correctly setup lspconfig for clangd 🚀
 {1 :neovim/nvim-lspconfig
  :opts {:servers {:clangd {:keys [{1 :<leader>cR
                                    2 :<cmd>ClangdSwitchSourceHeader<cr>
                                    :desc "Switch Source/Header (C/C++)"}]
                            :root_dir (fn [fname]
                                        (let [lspconfig-util (require :lspconfig.util)
                                              patterns [:Makefile
                                                        :configure.ac
                                                        :configure.in
                                                        :config.h.in
                                                        :meson.build
                                                        :meson_options.txt
                                                        :build.ninja]
                                              alt-patterns [:compile_commands.json
                                                            :compile_flags.txt]]
                                          (or ((lspconfig-util.root_pattern (unpack patterns)) fname)
                                              ((lspconfig-util.root_pattern (unpack alt-patterns)) fname)
                                              (lspconfig-util.find_git_ancestor fname))))
                            :capabilities {:offsetEncoding [:utf-16]}
                            :cmd [:clangd
                                  :--background-index
                                  :--clang-tidy
                                  :--header-insertion=iwyu
                                  :--completion-style=detailed
                                  :--function-arg-placeholders
                                  :--fallback-style=llvm]
                            :init_options {:usePlaceholders true
                                           :completeUnimported true
                                           :clangdFileStatus true}}}
         :setup {:clangd (fn [_ opts]
                           (let [clangd-ext-opts (get-lazy-opts :clangd_extensions.nvim)
                                 clangd-ext-opts (vim.tbl_deep_extend :force
                                                                      (or clangd-ext-opts
                                                                          {})
                                                                      {:server opts})
                                 clangd-ext (require :clangd_extensions)]
                             (clangd-ext.setup clangd-ext-opts)
                             false))}}}
 {1 :nvim-cmp
  :opts (fn [_ opts]
          (table.insert opts.sorting.comparators 1
                        (require :clangd_extensions.cmp_scores)))}]

