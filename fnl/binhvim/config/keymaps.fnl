;; This file is automatically loaded by plugins

(macro map [key cmd {: mode & opts}]
  (var keys (if (= (type key) :table) key [key]))
  (var mode (or mode :n))
  (set opts.silent true)
  `(values ,(unpack (icollect [_ key (ipairs keys)]
                      `(vim.keymap.set ,mode ,key ,cmd ,opts)))))

(macro remap [key cmd opts]
  (set opts.remap `vscode?)
  `(map ,key ,cmd ,opts))

(macro expr-map [key cmd opts]
  (set opts.expr true)
  `(map ,key ,cmd ,opts))

(macro diagnostic-goto [next severity]
  (let [go (if next `vim.diagnostic.goto_next `vim.diagnostic.goto_prev)
        opts (when severity
               `{:severity (. vim.diagnostic.severity ,severity)})]
    (if opts
        `#(,go ,opts)
        go)))

(macro toggle-option [option silent vals]
  (local get-opt-local `(: (. vim.opt_local ,option) :get))
  (if vals
      (let [[val1 val2] vals]
        `(fn []
           (tset vim.opt_local ,option
                 (if (= ,get-opt-local ,val1)
                     ,val2
                     ,val1))))
      `(fn []
         (tset vim.opt_local ,option (not ,get-opt-local)))))

(fn setup []
  (local vscode? (if vim.g.vscode true false))
  (local nu {:number true :relativenumber true})

  (fn toggle-number []
    (let [number (: vim.opt_local.number :get)
          relativenumber (: vim.opt_local.relativenumber :get)]
      (if (or number relativenumber)
          (do
            (set nu.number number)
            (set nu.relativenumber relativenumber)
            (set vim.opt_local.number false)
            (set vim.opt_local.relativenumber false))
          (do
            (set vim.opt_local.number nu.number)
            (set vim.opt_local.relativenumber nu.relativenumber)))))

  (local diagnostics? true)

  (fn toggle-diagnostic []
    ;; if this Neovim version supports checking if diagnostics are enabled
    ;; then use that for the current state
    (if vim.diagnostic.is_disabled
        (set diagnostic? (not (vim.diagnostic.is_disabled)))
        (set diagnostic? (not diagnostic?)))
    (if diagnostic? (do
                      (vim.diagnostic.enable))
        (do
          (vim.diagnostic.disable))))

  ;; Better up/down
  (expr-map [:j :<down>] "v:count == 0 ? 'gj' : 'j'"
            {:desc "Move Cursor Down (Allow Wrapped)"})
  (expr-map [:k :<up>] "v:count == 0 ? 'gk' : 'k'"
            {:desc "Move Cursor Up (Allow Wrapped)"})
  ;; Move to window using the <ctrl> hjkl keys
  (remap :<c-h> :<c-w>h {:desc "Move Cursor Left Window"})
  (remap :<c-j> :<c-w>j {:desc "Move Cursor Down Window"})
  (remap :<c-k> :<c-w>k {:desc "Move Cursor Up Window"})
  (remap :<c-l> :<c-w>l {:desc "Move Cursor Right Window"})
  ;; Resize window using <ctrl> arrow keys
  (map :<c-up> "<cmd>resize +2<cr>" {:desc "Increase Window Height"})
  (map :<c-down> "<cmd>resize -2<cr>" {:desc "Decrease Window Height"})
  (map :<c-left> "<cmd>vertical resize +2<cr>" {:desc "Increase Window Width"})
  (map :<c-right> "<cmd>vertical resize -2<cr>" {:desc "Decrease Window Width"})
  ;; Move Lines
  (map :<a-j> "<cmd>m .+1<cr>" {:desc "Move Down"})
  (map :<a-k> "<cmd>m .-2<cr>" {:desc "Move Up"})
  (map :<a-j> "<esc><cmd>m .+1<cr>gi" {:mode :i :desc "Move Down"})
  (map :<a-k> "<esc><cmd>m .-2<cr>gi" {:mode :i :desc "Move Up"})
  (map :<a-j> ":m '>+1<cr>gvgv" {:mode :v :desc "Move Down"})
  (map :<a-k> ":m '<-2<cr>gvgv" {:mode :v :desc "Move Up"})
  ;; buffers
  (map :<S-h> :<cmd>bprevious<cr> {:desc "Prev Buffer"})
  (map :<S-l> :<cmd>bnext<cr> {:desc "Next Buffer"})
  (map "[b" :<cmd>bprevious<cr> {:desc "Prev Buffer"})
  (map "]b" :<cmd>bnext<cr> {:desc "Next Buffer"})
  (map :<leader>bb "<cmd>e #<cr>" {:desc "Switch to Other Buffer"})
  (map "<leader>`" "<cmd>e #<cr>" {:desc "Switch to Other Buffer"})
  ;; Clear search with <esc>
  (map :<esc> :<cmd>noh<cr><esc>
       {:mode [:i :n] :desc "Escape and Clear hlsearch"})
  ;; Clear search diff update and redraw taken from runtime/lua/_editor.lua
  (map :<leader>ur "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>"
       {:desc "Redraw / Clear hlsearch / Diff Update"})
  ;; https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
  (expr-map :n "'Nn'[v:searchforward].'zv'" {:desc "Next Search Result"})
  (expr-map :n "'Nn'[v:searchforward]" {:mode :x :desc "Next Search Result"})
  (expr-map :n "'Nn'[v:searchforward]" {:mode :o :desc "Next Search Result"})
  (expr-map :N "'nN'[v:searchforward].'zv'" {:desc "Prev Search Result"})
  (expr-map :N "'nN'[v:searchforward]" {:mode :x :desc "Prev Search Result"})
  (expr-map :N "'nN'[v:searchforward]" {:mode :o :desc "Prev Search Result"})
  ;; Add undo break-points
  (map "," ",<c-g>u" {:mode :i})
  (map "." :.<c-g>u {:mode :i})
  (map ";" ";<c-g>u" {:mode :i})
  ;; Save file
  (map :<C-s> "<cmd>silent! update | redraw<cr><esc>"
       {:mode [:i :x :n :s] :desc "Save File"})
  ;; Keywordprg
  (map :<leader>K "<cmd>norm! K<cr>" {:desc :Keywordprg})
  ;; Better indenting
  (map "<" :<gv {:mode :v})
  (map ">" :>gv {:mode :v})
  ;; Lazy
  (map :<leader>l :<cmd>Lazy<cr> {:desc :Lazy})
  ;; New file
  (map :<leader>fn :<cmd>enew<cr> {:desc "New File"})
  ;; Quickfix / Location
  (map :<leader>xl :<cmd>lopen<cr> {:desc "Location List"})
  (map :<leader>xq :<cmd>copen<cr> {:desc "Quickfix List"})
  (map "[q" vim.cmd.cprev {:desc "Previous Quickfix"})
  (map "]q" vim.cmd.cnext {:desc "Next Quickfix"})
  ;; Diagnostic
  (map :<leader>cd vim.diagnostic.open_float {:desc "Line Diagnostics"})
  (map "]d" (diagnostic-goto true) {:desc "Next Diagnostic"})
  (map "[d" (diagnostic-goto false) {:desc "Prev Diagnostic"})
  (map "]e" (diagnostic-goto true :ERROR) {:desc "Next Error"})
  (map "[e" (diagnostic-goto false :ERROR) {:desc "Prev Error"})
  (map "]w" (diagnostic-goto true :WARN) {:desc "Next Warning"})
  (map "[w" (diagnostic-goto false :WARN) {:desc "Prev Warning"})
  ;; toggle options
  (map :<leader>us (toggle-option :spell) {:desc "Toggle Spelling"})
  (map :<leader>uw (toggle-option :wrap) {:desc "Toggle Word Wrap"})
  (map :<leader>uL (toggle-option :relativenumber)
       {:desc "Toggle Relative Line Numbers"})
  (map :<leader>ul toggle-number {:desc "Toggle Line Numbers"})
  (map :<leader>ud toggle-diagnostic {:desc "Toggle Diagnostics"})
  (local conceallevel (if (< 0 vim.o.conceallevel) vim.o.conceallevel 3))
  (map :<leader>uc (toggle-option :conceallevel false [0 conceallevel])
       {:desc "Toggle Conceal"})
  (map :<leader>uT #(if vim.b.ts_highlight (vim.treesitter.stop)
                        (vim.treesitter.start))
       {:desc "Toggle Treesitter Highlight"})
  (map :<leader>ub (toggle-option :background false [:light :dark])
       {:desc "Toggle Background"})
  ;; Quit
  (map :<leader>qq :<cmd>qa<cr> {:desc "Quit All"})
  ;; Highlights under cursor
  (map :<leader>ui vim.show_pos {:desc "Inspect Pos"})
  ;; Terminal Mappings
  (map :<esc><esc> "<c-\\><c-n>" {:mode :t :desc "Enter Normal Mode"})
  (map :<C-h> "<cmd>wincmd h<cr>" {:mode :t :desc "Go to Left Window"})
  (map :<C-j> "<cmd>wincmd j<cr>" {:mode :t :desc "Go to Lower Window"})
  (map :<C-k> "<cmd>wincmd k<cr>" {:mode :t :desc "Go to Upper Window"})
  (map :<C-l> "<cmd>wincmd l<cr>" {:mode :t :desc "Go to Right Window"})
  (map :<C-/> :<cmd>close<cr> {:mode :t :desc "Hide Terminal"})
  (map :<c-_> :<cmd>close<cr> {:mode :t :desc :which_key_ignore})
  ;; Windows
  (remap :<leader>ww :<C-W>p {:desc "Other Window"})
  (remap :<leader>wd :<C-W>c {:desc "Delete Window"})
  (remap :<leader>w- :<C-W>s {:desc "Split Window Below"})
  (remap :<leader>w| :<C-W>v {:desc "Split Window Right"})
  (remap :<leader>- :<C-W>s {:desc "Split Window Below"})
  (remap :<leader>| :<C-W>v {:desc "Split Window Right"})
  ;; Tabs
  (map :<leader><tab>l :<cmd>tablast<cr> {:desc "Last Tab"})
  (map :<leader><tab>f :<cmd>tabfirst<cr> {:desc "First Tab"})
  (map :<leader><tab><tab> :<cmd>tabnew<cr> {:desc "New Tab"})
  (map "<leader><tab>]" :<cmd>tabnext<cr> {:desc "Next Tab"})
  (map :<leader><tab>d :<cmd>tabclose<cr> {:desc "Close Tab"})
  (map "<leader><tab>[" :<cmd>tabprevious<cr> {:desc "Previous Tab"}))

{: setup}

