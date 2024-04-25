;; This file is automatically loaded by plugins

(macro disable_builtins [builtins]
  (icollect [_ builtin (ipairs builtins)]
    `(tset vim.g ,(.. :loaded_ builtin) 1)))

(macro disable_providers [providers]
  (icollect [_ provider (ipairs providers)]
    `(tset vim.g ,(.. :loaded_ provider :_provider) 0)))

(fn setup []
  (set vim.g.mapleader " ")
  (set vim.g.maplocalleader "\\")
  (set vim.opt.autowrite true) ; Enable auto write
  (when (not vim.env.SSH_TTY)
    (set vim.opt.clipboard :unnamedplus)) ; Sync with system clipboard
  (set vim.opt.completeopt "menu,menuone,noselect")
  (set vim.opt.conceallevel 2) ; Hide * markup for bold and italic, but not markers with substitutions
  (set vim.opt.confirm true) ; Confirm to save changes before exiting modified buffer
  (set vim.opt.cursorline true) ; Enable highlighting of the current line
  (set vim.opt.expandtab true) ; Use spaces instead of tabs
  (set vim.opt.formatoptions :jcroqlnt) ; tcqj
  (set vim.opt.grepformat "%f:%l:%c:%m")
  (set vim.opt.grepprg "rg --vimgrep")
  (set vim.opt.ignorecase true) ; Ignore case
  (set vim.opt.inccommand :nosplit) ; preview incremental substitute
  (set vim.opt.laststatus 3) ; global statusline
  (set vim.opt.list true) ; Show some invisible characters (tabs...
  (set vim.opt.mouse :a) ; Enable mouse mode
  (set vim.opt.number true) ; Print line number
  (set vim.opt.pumblend 10) ; Popup blend
  (set vim.opt.pumheight 10) ; Maximum number of entries in a popup
  (set vim.opt.relativenumber true) ; Relative line numbers
  (set vim.opt.scrolloff 4) ; Lines of context
  (set vim.opt.sessionoptions [:buffers
                               :curdir
                               :tabpages
                               :winsize
                               :help
                               :globals
                               :skiprtp
                               :folds])
  (set vim.opt.shiftround true) ; Round indent
  (set vim.opt.shiftwidth 2) ; Size of an indent
  (vim.opt.shortmess:append {:W true :I true :c true :C true})
  (set vim.opt.showmode false) ; Dont show mode since we have a statusline
  (set vim.opt.sidescrolloff 8) ; Columns of context
  (set vim.opt.signcolumn :yes) ; Always show the signcolumn, otherwise it would shift the text each time
  (set vim.opt.smartcase true) ; Don't ignore case with capitals
  (set vim.opt.smartindent true) ; Insert indents automatically
  (set vim.opt.spelllang [:en])
  (set vim.opt.splitbelow true) ; Put new windows below current
  (set vim.opt.splitkeep :screen)
  (set vim.opt.splitright true) ; Put new windows right of current
  (set vim.opt.tabstop 2) ; Number of spaces tabs count for
  (set vim.opt.termguicolors true) ; True color support
  (when (not vim.g.vscode)
    (set vim.opt.timeoutlen 300)) ; Lower than default (1000) to quickly trigger which-key
  (set vim.opt.undofile true)
  (set vim.opt.undolevels 10000)
  (set vim.opt.updatetime 200) ; Save swap file and trigger CursorHold
  (set vim.opt.virtualedit :block) ; Allow cursor to move where there is no text in visual block mode
  (set vim.opt.wildmode "longest:full,full") ; Command-line completion mode
  (set vim.opt.winminwidth 5) ; Minimum window width
  (set vim.opt.wrap false) ; Disable line wrap
  (set vim.opt.fillchars {:foldopen ""
                          :foldclose ""
                          :fold " "
                          :foldsep " "
                          :diff "╱"
                          :eob " "})
  (when (= (vim.fn.has :nvim-0.10) 1)
    (set vim.opt.smoothscroll true))
  (disable_builtins [:2html_plugin
                     :getscript
                     :getscriptPlugin
                     :gzip
                     :logipat
                     :netrw
                     :netrwPlugin
                     :netrwSettings
                     :netrwFileHandlers
                     :tar
                     :tarPlugin
                     :rrhelper
                     :spellfile_plugin
                     :vimball
                     :vimballPlugin
                     :zip
                     :zipPlugin
                     :logipat
                     :matchit
                     :tutor
                     :rplugin
                     :syntax
                     :synmenu
                     :optwin
                     :compiler
                     :bugreport
                     :ftplugin
                     :archlinux
                     :fzf
                     :tutor_mode_plugin
                     :sleuth
                     :vimgrep])
  (disable_providers [:node :perl :python3 :ruby]))

{: setup}

