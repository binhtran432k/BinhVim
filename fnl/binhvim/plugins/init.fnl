(if (= (vim.fn.has :nvim-0.9.0) 0)
    (do
      (vim.api.nvim_echo [["BinhVim requires Neovim >= 0.9.0\n" :ErrorMsg]
                          ["Press any key to exit" :MoreMsg]]
                         true {})
      (vim.fn.getchar)
      (vim.cmd :quit)
      {})
    (let [{: init} (require :binhvim.config)]
      (init)
      [;;; Core
       ;; package manager
       {1 :folke/lazy.nvim :version "*"}
       ;; neovim distribution
       {1 :binhtran432k/BinhVim
        :priority 10000
        :lazy false
        :config true
        :cond true
        :version "*"}
       ;; fennel compiler
       {1 :Olical/nfnl :ft :fennel :event :LazyFile}
       ;;; Util
       ;; measure startuptime
       {1 :dstein64/vim-startuptime
        :cmd :StartupTime
        :config #(set vim.g.startuptime_tries 10)}
       ;; library used by other plugins
       {1 :nvim-lua/plenary.nvim :lazy true}
       ;;; Colorscheme
       {1 :binhtran432k/dracula.nvim :lazy true}
       ;;; UI
       ;; icons
       {1 :nvim-tree/nvim-web-devicons :lazy true}]))

