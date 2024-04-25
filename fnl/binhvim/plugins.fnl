(macro load-config [config-name call]
  `#((. (require ,(.. :binhvim.config.plugins. config-name)) ,call) $...))

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
      [{1 :folke/lazy.nvim :version "*"}
       {1 :binhtran432k/BinhVim
        :priority 10000
        :lazy false
        :config true
        :cond true
        :version "*"}
       {1 :Olical/nfnl :ft :fennel :event :VeryLazy}
       {1 :nvim-lua/plenary.nvim}
       {1 :nvim-treesitter/nvim-treesitter
        :event :VeryLazy
        :cmd [:TSInstall
              :TSBufEnable
              :TSBufDisable
              :TSModuleInfo
              :TSUninstall
              :TSUpdate]
        :keys [{1 :<c-space> :desc "Increment Selection"}
               {1 :<bs> :desc "Decrement Selection" :mode :x}]
        :build ":TSUpdate"
        :init (load-config :treesitter :init)
        :opts (load-config :treesitter :opts)
        :config (load-config :treesitter :config)}
       {1 :hrsh7th/nvim-cmp
        :event [:InsertEnter :CmdlineEnter]
        :dependencies [:hrsh7th/cmp-buffer
                       :hrsh7th/cmp-path
                       :hrsh7th/cmp-cmdline
                       :hrsh7th/cmp-nvim-lsp
                       :hrsh7th/cmp-nvim-lua
                       :saadparwaiz1/cmp_luasnip
                       :onsails/lspkind.nvim]
        :opts (load-config :cmp :opts)
        :config (load-config :cmp :config)}
       {1 :windwp/nvim-ts-autotag
        :event :VeryLazy
        :ft [:html
             :javascript
             :jsx
             :typescript
             :tsx
             :svelte
             :vue
             :xml
             :markdown]
        :opts {}}
       {1 :numToStr/Comment.nvim
        :dependencies [{1 :JoosepAlviste/nvim-ts-context-commentstring
                        :opts {:enable_autocmd false}}]
        :keys [{1 :gc :desc "+comment line" :mode [:n :x]}
               {1 :gb :desc "+comment block" :mode [:n :x]}]
        :opts #{:pre_hook ((. (require :ts_context_commentstring.integrations.comment_nvim)
                              :create_pre_hook))}}
       {1 :NvChad/nvim-colorizer.lua
        :event :VeryLazy
        :opts {:user_default_options {:tailwind true}}}
       {1 :stevearc/conform.nvim
        :cmd :ConformInfo
        :keys (load-config :conform :keys)
        :opts (load-config :conform :opts)}
       {1 :williamboman/mason.nvim
        :cmd [:Mason]
        :init (load-config :mason :init)
        :opts (load-config :mason :opts)}
       {1 :folke/which-key.nvim
        :keys [:<leader> " " "'" "`" "\"" :g :v :c :d]
        :cmd :WhichKey
        :opts (load-config :whichkey :opts)}
       {1 :stevearc/oil.nvim
        :keys [{1 "-" 2 :<cmd>Oil<cr> :desc "Open parent directory"}]
        :cmd :Oil
        :opts {}}
       {1 :nvim-tree/nvim-tree.lua
        :keys [{1 :<leader>e 2 :<cmd>NvimTreeToggle<cr> :desc :Explorer}]
        :cmd [:NvimTreeToggle
              :NvimTreeFocus
              :NvimTreeFindFile
              :NvimTreeCollapse]
        :opts {}
        :config #((. (require :nvim-tree) :setup) $2)}]))

