[;; Add Rust & related to treesitter
 {1 :nvim-treesitter/nvim-treesitter
  :opts {:binh_ensure_installed {:ron true :rust true :toml true}}}
 ;; Correctly setup lspconfig for Rust 🚀
 {1 :neovim/nvim-lspconfig :opts {:servers {:rust_analyzer {}}}}]

