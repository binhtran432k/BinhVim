(import-macros {: autocmd} :binhvim.macros)

(macro load [pname]
  `(do
     ((. (require ,(.. :binhvim.config. pname)) :setup))
     (pcall require ,(.. :config. pname))))

(fn lazy-file []
  (let [lazy-file? (< 0 (vim.fn.argc -1))
        event-plug (require :lazy.core.handler.event)]
    (if lazy-file?
        (do
          ;; We'll handle delayed execution of events ourselves
          (set event-plug.mappings.LazyFile
               {:id :LazyFile :event :User :pattern :LazyFile})
          (tset event-plug.mappings "User LazyFile"
                event-plug.mappings.LazyFile))
        (do
          ;; Don't delay execution of LazyFile events, but let lazy know about the mapping
          (set event-plug.mappings.LazyFile
               {:id :LazyFile :event [:BufReadPost :BufNewFile :BufWritePre]})
          (tset event-plug.mappings "User LazyFile"
                event-plug.mappings.LazyFile)))
    (when lazy-file?
      (var events [])
      (var done false)

      (fn load-event []
        (when (not (or (= (length events) 0) done))
          (set done true)
          (vim.api.nvim_del_augroup_by_name :lazy_file)
          (var skips [])
          (each [_ {: event} (ipairs events)]
            (tset skips event
                  (or (. skips event) (event-plug.get_augroups event))))
          (vim.api.nvim_exec_autocmds :User
                                      {:pattern :LazyFile :modeline false})
          (each [_ {: event : data : buf} (ipairs events)]
            (when (vim.api.nvim_buf_is_valid buf)
              (event-plug.trigger {: event
                                   :exclude (. skips event)
                                   : data
                                   : buf})
              (when (. (. vim.bo buf) :filetype)
                (event-plug.trigger {:event :FileType : buf}))))
          (vim.api.nvim_exec_autocmds :CursorMoved {:modeline false})
          (set events [])))

      (let [load-event-async (vim.schedule_wrap load-event)
            group (vim.api.nvim_create_augroup :lazy_file {:clear true})]
        (vim.api.nvim_create_autocmd [:BufReadPost :BufNewFile :BufWritePre]
                                     {: group
                                      :callback (fn [event]
                                                  (table.insert events event)
                                                  (load-event-async))})))))

(var init? false)
(fn init []
  (when init?
    (lua :return))
  (set init? true)
  (let [lazy-config (require :lazy.core.config)
        plugin lazy-config.spec.plugins.LazyVim]
    (when plugin
      (vim.opt.rtp:append plugin.dir)))
  ;; load options here, before lazy init while sourcing plugin modules
  ;; this is needed to make sure options will be correctly applied
  ;; after installing missing plugins
  (load :options)
  (lazy-file))

(fn setup [opts]
  (let [colorscheme (or opts.colorscheme :dracula)
        ;; autocmds can be loaded lazily when not opening a file
        lazy-autocmds? (= (vim.fn.argc -1) 0)]
    (pcall vim.cmd (.. "colorscheme " colorscheme))
    (when (not lazy-autocmds?)
      (load :autocmds))
    (autocmd :User {:group :BinhVim
                    :pattern :VeryLazy
                    :callback (fn []
                                (when lazy-autocmds?
                                  (load :autocmds))
                                (load :keymaps))})))

{: init : setup}

