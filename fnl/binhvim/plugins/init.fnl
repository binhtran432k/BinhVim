(if (= (vim.fn.has :nvim-0.9.0) 0)
    (do 
      (vim.api.nvim_echo [
			  ["BinhVim requires Neovim >= 0.9.0\n" :ErrorMsg]
			  ["Press any key to exit" :MoreMsg]
			  ] true {})
      (vim.fn.getchar)
      (vim.cmd :quit)
      {})
    (let [{: init} (require :binhvim.config)]
      (init)
      [
       { 1 :folke/lazy.nvim :version :* }
       { 1 :binhtran432k/BinhVim :priority 10000 :lazy false :config true :cond true :version :* }
       ]))
