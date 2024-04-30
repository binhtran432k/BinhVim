(import-macros {: run-in-directory?} :binhvim.macros)

;; alternative file explorer with batch manipulation
{1 :stevearc/oil.nvim
 :keys [{1 "-" 2 :<cmd>Oil<cr> :desc "Open parent directory"}]
 :cmd :Oil
 :init #(run-in-directory? (vim.cmd :Oil))
 :opts {}}

