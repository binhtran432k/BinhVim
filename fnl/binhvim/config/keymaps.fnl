(macro map [key cmd {: mode : desc & opts}]
  (var mode (or mode :n))
  `(vim.keymap.set ,mode ,key ,cmd ,opts {:desc ,desc}))

(macro quick-map [key cmd opts]
  (set opts.noremap true)
  (set opts.silent true)
  `(map ,key ,cmd ,opts))

(macro expr-map [key cmd opts]
  (set opts.expr true)
  `(map ,key ,cmd ,opts))

(fn setup []
  (expr-map :j "v:count || mode(1)[0:1] == 'no' ? 'j' : 'gj'" {:desc "Move Cursor Down (Allow Wrapped)"})
  (expr-map :k "v:count || mode(1)[0:1] == 'no' ? 'k' : 'gk'" {:desc "Move Cursor Up (Allow Wrapped)"})

  (quick-map :<c-s> "<cmd>silent! update | redraw<cr>" {:desc "Save"})
  (quick-map :<c-s> "<esc><cmd>silent! update | redraw<cr>" {:desc "Save and go to Normal mode" :mode [:i :x]})

  (quick-map :<c-h> :<c-w>h {:desc "Move Cursor Left Buffer"})
  (quick-map :<c-j> :<c-w>j {:desc "Move Cursor Down Buffer"})
  (quick-map :<c-k> :<c-w>k {:desc "Move Cursor Up Buffer"})
  (quick-map :<c-l> :<c-w>l {:desc "Move Cursor Right Buffer"})

  (quick-map :<c-up> "<cmd>resize +2<cr>" {:desc "Resize Window Up"})
  (quick-map :<c-down> "<cmd>resize -2<cr>" {:desc "Resize Window Down"})
  (quick-map :<c-left> "<cmd>vertical resize +2<cr>" {:desc "Resize Window Left"})
  (quick-map :<c-right> "<cmd>vertical resize -2<cr>" {:desc "Resize Window Right"})

  (quick-map :<leader>q :<cmd>qa!<cr> {:desc "Quit" :mode [:n :v]})
  (quick-map :<enter> :<cmd>nohlsearch<cr> {:desc "Clear highlight"}))

{: setup}
