;; git signs highlights text that has changed since the list
;; git commit, and also lets you interactively stage & unstage
;; hunks in a commit.
{1 :lewis6991/gitsigns.nvim
 :event :LazyFile
 :opts {:on_attach (fn [buffer]
                     (macro map [mode l r desc]
                       `(vim.keymap.set ,mode ,l ,r {: buffer :desc ,desc}))
                     (let [gs package.loaded.gitsigns]
                       (map :n "]h" gs.next_hunk "Next Hunk")
                       (map :n "[h" gs.prev_hunk "Prev Hunk")
                       (map [:n :v] :<leader>ghs ":Gitsigns stage_hunk<CR>"
                            "Stage Hunk")
                       (map [:n :v] :<leader>ghr ":Gitsigns reset_hunk<CR>"
                            "Reset Hunk")
                       (map :n :<leader>ghS gs.stage_buffer "Stage Buffer")
                       (map :n :<leader>ghu gs.undo_stage_hunk
                            "Undo Stage Hunk")
                       (map :n :<leader>ghR gs.reset_buffer "Reset Buffer")
                       (map :n :<leader>ghp gs.preview_hunk_inline
                            "Preview Hunk Inline")
                       (map :n :<leader>ghb #(gs.blame_line {:full true})
                            "Blame Line")
                       (map :n :<leader>ghd gs.diffthis "Diff This")
                       (map :n :<leader>ghD #(gs.diffthis "~") "Diff This ~")
                       (map [:o :x] :ih ":<C-U>Gitsigns select_hunk<CR>"
                            "GitSigns Select Hunk")))}}

