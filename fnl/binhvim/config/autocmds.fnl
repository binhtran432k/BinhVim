;; This file is automatically loaded by plugins

(import-macros {: autocmd} :binhvim.macros)

(macro close-with-q [buf]
  `(do
     (tset (. vim.bo buf) :buflisted false)
     (vim.keymap.set :n :q :<cmd>close<cr>
                     {:desc "Close window"
                      :buffer buf
                      :silent true
                      :nowait true})))

(macro set-indent [opts]
  `(let [args# (. ,opts :args)
         indent# (if (not= args# "") (tonumber args#) 4)]
     (tset vim.bo :shiftwidth indent#)
     (tset vim.bo :softtabstop indent#)
     (tset vim.bo :tabstop indent#)))

(fn setup []
  ;; Check if we need to reload the file when it changed
  (autocmd [:FocusGained :TermClose :TermLeave]
           {:group :checktime
            :callback (fn []
                        (when (not= vim.o.buftype :nofile)
                          (vim.cmd "checktime | redraw")))})
  ;; Highlight on yank
  (autocmd :TextYankPost
           {:group :highlight_yank
            :pattern "*"
            :callback #(vim.highlight.on_yank)})
  ;; Resize splits if window got resized
  (autocmd :VimResized
           {:group :resize_splits
            :callback (fn []
                        (let [current_tab (vim.fn.tabpagenr)]
                          (vim.cmd "tabdo wincmd =")
                          (vim.cmd (.. "tabnext " current_tab))))})
  ;; Go to last loc when opening a buffer
  (autocmd :BufReadPost
           {:group :last_loc
            :callback (fn [event]
                        (let [excludes [:gitcommit :starter]
                              buf event.buf
                              ft (. (. vim.bo buf) :filetype)
                              buf_vars (. vim.b buf)]
                          (when (not (or (vim.tbl_contains excludes ft)
                                         buf_vars.lazyvim_last_loc))
                            (set buf_vars.lazyvim_last_loc true)
                            (let [mark (vim.api.nvim_buf_get_mark buf "\"")
                                  lcount (vim.api.nvim_buf_line_count buf)]
                              (when (and (< 0 (. mark 1))
                                         (<= (. mark 1) lcount))
                                (pcall vim.api.nvim_win_set_cursor 0 mark))))))})
  ;; Close some filetypes with <q>
  (autocmd :FileType {:group :close_with_q_filetype
                      :pattern [:help
                                :PlenaryTestPopup
                                :lspinfo
                                :notify
                                :qf
                                :query
                                :spectre_panel
                                :startuptime
                                :tsplayground
                                :neotest-output
                                :checkhealth
                                :neotest-summary
                                :neotest-output-panel]
                      :callback (fn [{: buf}]
                                  (close-with-q buf))})
  ;; Close some buftypes with <q>
  (autocmd :BufWinEnter
           {:group :close_with_q_buftype
            :callback (fn [{: buf}]
                        (let [buftype (vim.api.nvim_get_option_value :buftype
                                                                     {: buf})
                              buftype-ignored? (and (vim.tbl_contains [:nofile
                                                                       :quickfix
                                                                       :help]
                                                                      buftype)
                                                    (= (vim.fn.maparg :q :n) ""))]
                          (when buftype-ignored?
                            (close-with-q buf))))})
  ;; Make it easier to close man-files when opened inline
  (autocmd :FileType
           {:group :man_unlisted
            :pattern [:man]
            :callback (fn [event]
                        (tset (. vim.bo event.buf) :buflisted false))})
  ;; Wrap and check for spell in text filetypes
  (autocmd :FileType
           {:group :wrap_spell
            :pattern [:gitcommit :markdown]
            :callback (fn []
                        (set vim.opt_local.wrap true)
                        (set vim.opt_local.spell true))})
  ;; Fix conceallevel for json files
  (autocmd :FileType
           {:group :json_conceal
            :pattern [:json :jsonc :json5]
            :callback (fn []
                        (set vim.opt_local.conceallevel 0))})
  ;; Auto create dir when saving a file, in case some intermediate directory does not exist
  (autocmd :BufWritePre
           {:group :auto_create_dir
            :callback (fn [event]
                        (when (not (event.match:match "^%w%w+://"))
                          (vim.fn.mkdir (vim.fn.fnamemodify (or (vim.loop.fs_realpath event.match)
                                                                (event.match))
                                                            ":p:h")
                                        :p)))})
  ;; Disable number and cursorline in terminal
  (autocmd :TermOpen {:group :simplify_terminal
                      :pattern "*"
                      :callback (fn []
                                  (set vim.opt_local.number false)
                                  (set vim.opt_local.cursorline false)
                                  (set vim.opt_local.foldcolumn :0)
                                  (set vim.opt_local.signcolumn :no)
                                  (vim.cmd :startinsert))})
  ;; Disable miniindentscope, number, and cursorline in specific filetypes
  (autocmd :FileType
           {:group :simplify_ui
            :pattern [:neo-tree
                      :PlenaryTestPopup
                      :checkhealth
                      :fugitive
                      :git
                      :gitcommit
                      :help
                      :lazy
                      :lazyterm
                      :lspinfo
                      :man
                      :mason
                      :notify
                      :qf
                      :NvimTree
                      :query
                      :spectre_panel
                      :startuptime
                      :tsplayground
                      :Trouble
                      :trouble
                      :toggleterm]
            :callback #(do
                         (set vim.opt_local.number false)
                         (set vim.opt_local.cursorline false)
                         (set vim.b.miniindentscope_disable true))})
  (vim.api.nvim_create_user_command :IndentTab
                                    (fn [opts]
                                      (set vim.bo.expandtab false)
                                      (set-indent opts))
                                    {:nargs "?"})
  (vim.api.nvim_create_user_command :IndentSpace
                                    (fn [opts]
                                      (set vim.bo.expandtab true)
                                      (set-indent opts))
                                    {:nargs "?"}))

{: setup}

