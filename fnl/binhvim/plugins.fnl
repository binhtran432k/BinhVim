(macro load-config [config-name call]
  `#((. (require ,(.. :binhvim.config.plugins. config-name)) ,call) $...))

(macro run-when-directory [cmd]
  `(when (= (vim.fn.argc -1) 1)
     (let [stat# (vim.uv.fs_stat (vim.fn.argv 0))]
       (when (and stat# (= stat#.type :directory))
         ,cmd))))

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
       ;;; Treesitter
       ;; treesitter is a new parser generator tool that we can
       ;; use in Neovim to power faster and more accurate
       ;; syntax highlighting.
       {1 :nvim-treesitter/nvim-treesitter
        :version false
        :dependencies [{1 :nvim-treesitter/nvim-treesitter-textobjects
                        :config (load-config :treesitter :textobjects_config)}
                       {1 :HiPhish/rainbow-delimiters.nvim}]
        :event [:LazyFile :VeryLazy]
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
       ;; automatically add closing tags for HTML and JSX
       {1 :windwp/nvim-ts-autotag
        :event :LazyFile
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
       ;;; Coding
       ;; auto completion
       {1 :hrsh7th/nvim-cmp
        :version false
        :event [:InsertEnter :CmdlineEnter]
        :dependencies [:hrsh7th/cmp-buffer
                       :hrsh7th/cmp-path
                       :hrsh7th/cmp-cmdline
                       :hrsh7th/cmp-nvim-lsp
                       :hrsh7th/cmp-nvim-lua
                       :onsails/lspkind.nvim
                       ;; snippets
                       {1 :garymjr/nvim-snippets
                        :dependencies :rafamadriz/friendly-snippets
                        :keys (load-config :snippets :keys)
                        :opts (load-config :snippets :opts)}]
        :opts (load-config :cmp :opts)
        :config (load-config :cmp :config)}
       ;; auto pairs
       {1 :windwp/nvim-autopairs
        :event :InsertEnter
        :dependencies {1 :nvim-treesitter/nvim-treesitter
                       :opts {:autopairs {:enable true}}}
        :opts (load-config :autopairs :opts)
        :config (load-config :autopairs :config)}
       ;; fast and feature-rich surround actions. For text that includes
       ;; surrounding characters like brackets or quotes, this allows you
       ;; to select the text inside, change or modify the surrounding characters,
       ;; and more.
       {1 :echasnovski/mini.surround
        :keys (load-config :surround :keys)
        :opts (load-config :surround :opts)}
       ;; comments
       {1 :JoosepAlviste/nvim-ts-context-commentstring
        :lazy true
        :opts {:enable_autocmd false}}
       {1 :numToStr/Comment.nvim
        :keys [{1 :gc :desc "+comment line" :mode [:n :x]}
               {1 :gb :desc "+comment block" :mode [:n :x]}]
        :opts (fn []
                {:pre_hook ((. (require :ts_context_commentstring.integrations.comment_nvim)
                               :create_pre_hook))})}
       ;; better text-objects
       {1 :echasnovski/mini.ai
        :event :VeryLazy
        :opts (load-config :ai :opts)
        :config (load-config :ai :config)}
       {1 :folke/which-key.nvim :opts (load-config :ai :wk_opts)}
       ;;; Editor
       ;; file explorer
       {1 :nvim-tree/nvim-tree.lua
        :version "*"
        :keys [{1 :<leader>e 2 :<cmd>NvimTreeToggle<cr> :desc :Explorer}
               {1 :<leader>fe
                2 :<cmd>NvimTreeFindFileToggle<cr>
                :desc "Explorer Focus File"}]
        :cmd [:NvimTreeToggle
              :NvimTreeFocus
              :NvimTreeFindFile
              :NvimTreeCollapse]
        :opts {}
        :config #((. (require :nvim-tree) :setup) $2)}
       ;; alternative file explorer with batch manipulation
       {1 :stevearc/oil.nvim
        :keys [{1 "-" 2 :<cmd>Oil<cr> :desc "Open parent directory"}]
        :cmd :Oil
        :init #(run-when-directory (vim.cmd :Oil))
        :opts {}}
       ;; search/replace in multiple files
       {1 :nvim-pack/nvim-spectre
        :build false
        :cmd :Spectre
        :opts {:open_cmd "noswapfile vnew"}
        :keys [{1 :<leader>sr
                2 #((. (require :spectre) :open))
                :desc "Replace in Files (Spectre)"}]}
       ;; Fuzzy finder.
       ;; The default key bindings to find files will use Telescope's
       ;; `find_files` or `git_files` depending on whether the
       ;; directory is a git repo.
       {1 :nvim-telescope/telescope.nvim
        :cmd :Telescope
        :version false
        :dependencies [:nvim-telescope/telescope-symbols.nvim
                       {1 :nvim-telescope/telescope-fzf-native.nvim
                        :build (if (= (vim.fn.executable :make) 1) :make
                                   "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build")
                        :enabled (or (= (vim.fn.executable :make) 1)
                                     (= (vim.fn.executable :cmake) 1))}]
        :keys (load-config :telescope :keys)
        :opts (load-config :telescope :opts)
        :config (load-config :telescope :config)}
       ;; Flash enhances the built-in search functionality by showing labels
       ;; at the end of each match, letting you quickly jump to a specific
       ;; location.
       {1 :folke/flash.nvim
        :event :VeryLazy
        :vscode true
        :opts {}
        :keys (load-config :flash :keys)}
       ;; which-key helps you remember key bindings by showing a popup
       ;; with the active keybindings of the command you started typing.
       {1 :folke/which-key.nvim
        :event :VeryLazy
        :cmd :WhichKey
        :opts (load-config :whichkey :opts)
        :config (load-config :whichkey :config)}
       ;; git signs highlights text that has changed since the list
       ;; git commit, and also lets you interactively stage & unstage
       ;; hunks in a commit.
       {1 :lewis6991/gitsigns.nvim
        :event :LazyFile
        :opts (load-config :gitsigns :opts)}
       ;; Automatically highlights other instances of the word under your cursor.
       ;; This works with LSP, Treesitter, and regexp matching to find the other
       ;; instances.
       {1 :RRethy/vim-illuminate
        :event :LazyFile
        :keys [{1 "]]" :desc "Next Reference"} {1 "[[" :desc "Prev Reference"}]
        :opts (load-config :illuminate :opts)
        :config (load-config :illuminate :config)}
       ;;; Colorscheme
       {1 :binhtran432k/dracula.nvim :lazy true}
       ;;; UI
       {1 :NvChad/nvim-colorizer.lua
        :event :VeryLazy
        :opts {:user_default_options {:tailwind true}}}
       ;;; LSP
       ;; formatter
       {1 :stevearc/conform.nvim
        :cmd :ConformInfo
        :keys (load-config :conform :keys)
        :opts (load-config :conform :opts)}
       ;; cmdline tools and lsp servers installer
       {1 :williamboman/mason.nvim
        :cmd [:Mason]
        :keys [{1 :<leader>cm 2 :<cmd>Mason<cr> :desc :Mason}]
        :init (load-config :mason :init)
        :opts (load-config :mason :opts)}]))

