(macro autocmd [event {: group : callback : desc : pattern}]
  `(vim.api.nvim_create_autocmd ,event {
								:group ,(and group `(vim.api.nvim_create_augroup
													  ,group
													  {:clear true}))
								:callback ,callback
								:desc ,desc
								:pattern ,pattern}))

(fn setup []
  (autocmd :BufWritePre {
		   :group :auto_create_dir
		   :callback (fn [args]
					   (when (not (args.match:match :^%w%w+://))
						 (vim.fn.mkdir
						   (vim.fn.fnamemodify
							 (or
							   (vim.loop.fs_realpath args.match)
							   (args.match))
							 ::p:h)
						   :p)))
		   :desc "Automatically create parent directories if they don't exist when saving a file"})
  (autocmd :TextYankPost {
		   :group :highlight_yank
		   :pattern :*
		   :callback #(vim.highlight.on_yank)
		   :desc "Highlight yanked text"})
  (autocmd :TermOpen {
		   :pattern :*
		   :callback #(do
						(set vim.opt_local.number false)
						(set vim.opt_local.cursorline false)
						(set vim.opt_local.foldcolumn :0)
						(set vim.opt_local.signcolumn :no)
						(vim.cmd :startinsert))
		   :desc "Disable number and cursorline in terminal"})
  (autocmd :FileType {
		   :pattern [
					 :neo-tree
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
					 :query
					 :spectre_panel
					 :startuptime
					 :tsplayground
					 :Trouble
					 :trouble
					 :toggleterm
					 ]
		   :callback #(do
						(set vim.opt_local.number false)
						(set vim.opt_local.cursorline false)
						(set vim.b.miniindentscope_disable true))
		   :desc "Disable miniindentscope, number, and cursorline in specific filetypes"})
  (autocmd :BufWinEnter {
		   :group :q_close_windows
		   :callback (fn [args]
					   (let [buftype (vim.api.nvim_get_option_value :buftype {:buf args.buf})]
						 (when (and
								 (vim.tbl_contains [:help :nofile :quickfix] buftype)
								 (= (vim.fn.maparg :q :n) ""))
						   (vim.keymap.set :n :q :<cmd>close<cr> {
										   :desc "Close window"
										   :buffer args.buf
										   :silent true
										   :nowait true}))))
		   :desc "Make q close help, man, quickfix, dap floats"}))

{: setup}
