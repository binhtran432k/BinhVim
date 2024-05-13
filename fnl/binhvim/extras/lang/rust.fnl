[;; Add Rust & related to treesitter
 {1 :nvim-treesitter/nvim-treesitter
  :opts {:binh_ensure_installed {:ron true :rust true :toml true}}}
 ;; Correctly setup lspconfig for Rust 🚀
 {1 :neovim/nvim-lspconfig
  :opts {:servers {:rust_analyzer {}} :setup {:rust_analyzer #true}}}
 {1 :mrcjkb/rustaceanvim
  ;; Recommended
  :version :^4
  :ft [:rust]
  :opts {:server {:on_attach (fn [_ bufnr]
                               (vim.keymap.set :n :<leader>cR
                                               (fn []
                                                 (vim.cmd.RustLsp :codeAction))
                                               {:desc "Code Action"
                                                :buffer bufnr}))
                  :default_settings {;; rust-analyzer language server configuration
                                     :rust-analyzer {:cargo {:allFeatures true
                                                             :loadOutDirsFromCheck true
                                                             :buildScripts {:enable true}}
                                                     ;; Add clippy lints for Rust.
                                                     :checkOnSave {:allFeatures true
                                                                   :command :clippy
                                                                   :extraArgs [:--no-deps]}
                                                     :procMacro {:enable true
                                                                 :ignored {:async-trait [:async_trait]
                                                                           :napi-derive [:napi]
                                                                           :async-recursion [:async_recursion]}}}}}}
  :config (fn [_ opts]
            (set vim.g.rustaceanvim
                 (vim.tbl_deep_extend :keep (or vim.g.rustaceanvim {})
                                      (or opts {}))))}]

