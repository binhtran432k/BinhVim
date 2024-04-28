(fn has-words-before []
  (let [[line col] (vim.api.nvim_win_get_cursor 0)]
    (and (not= col 0) (let [[current-line] (vim.api.nvim_buf_get_lines 0
                                                                       (- line
                                                                          1)
                                                                       line true)
                            word-before (current-line:sub col col)]
                        (= (word-before:match "%s") nil)))))

(fn supertab-next [fallback]
  (local cmp (require :cmp))
  (if (cmp.visible) (cmp.select_next_item)
      (vim.snippet.jumpable 1) (vim.schedule #(vim.snippet.jump 1))
      (has_words_before) (cmp.complete)
      (fallback)))

(fn supertab-prev [fallback]
  (local cmp (require :cmp))
  (if (cmp.visible) (cmp.select_prev_item)
      (vim.snippet.jumpable -1) (vim.schedule #(vim.snippet.jump -1))
      (fallback)))

(fn opts []
  (vim.api.nvim_set_hl 0 :CmpGhostText {:link :Comment :default true})
  (let [cmp (require :cmp)
        defaults ((require :cmp.config.default))
        lspkind (require :lspkind)]
    {;; configure any filetype to auto add brackets
     :auto_brackets []
     :completion {:completeopt "menu,menuone,noinsert"}
     :binh_action {:next (cmp.mapping.select_next_item {:behavior cmp.SelectBehavior.Insert})
                   :prev (cmp.mapping.select_prev_item {:behavior cmp.SelectBehavior.Insert})
                   :supertab_next supertab-next
                   :supertab_prev supertab-prev
                   :scroll_prev (cmp.mapping.scroll_docs 4)
                   :scroll_next (cmp.mapping.scroll_docs -4)
                   :scroll_prev (cmp.mapping.scroll_docs 4)
                   :complete (cmp.mapping.complete)
                   :toggle #(if (cmp.visible) (cmp.close) (cmp.complete))
                   :abort (cmp.mapping.abort)
                   ;; Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                   :select (cmp.mapping.confirm {:select true})
                   ;; Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                   :select_replace (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace
                                                         :select true})
                   :cr (fn [fallback]
                         (cmp.abort)
                         (fallback))}
     :binh_key {:<c-j> :next
                :<c-k> :prev
                :<c-u> :scroll_next
                :<c-d> :scroll_prev
                :<c-space> :toggle
                :<c-e> :abort
                :<c-y> :select
                :<cr> :select
                :<s-cr> :select_replace
                :<c-cr> :cr}
     :binh_key_cmdline {:<c-j> :next :<c-k> :prev :<c-space> :toggle}
     :sources (cmp.config.sources [{:name :nvim_lsp}
                                   {:name :snippets}
                                   {:name :path}]
                                  [{:name :buffer}])
     :formatting {:format (lspkind.cmp_format {})}
     :experimental {:ghost_text {:hl_group :CmpGhostText}}
     :sorting defaults.sorting}))

(fn config [_ opts]
  (local cmp (require :cmp))
  (each [_ source (ipairs opts.sources)]
    (set source.group_index (or source.group_index 1)))
  (set opts.mapping
       (cmp.mapping.preset.insert (collect [key action (pairs opts.binh_key)]
                                    (values key (. opts.binh_action action)))))
  (let [Kind cmp.lsp.CompletionItemKind
        on-confirm (fn [event]
                     (when (vim.tbl_contains (or opts.auto_brackets [])
                                             vim.bo.filetype)
                       (let [entry event.entry
                             item (entry:get_completion_item)
                             keys (vim.api.nvim_replace_termcodes "()<left>"
                                                                  false false
                                                                  true)]
                         (when (vim.tbl_contains [Kind.Function Kind.Method]
                                                 item.kind)
                           (vim.api.nvim_feedkeys keys :i true)))))
        cmdline-mapping (cmp.mapping.preset.cmdline (collect [key action (pairs opts.binh_key_cmdline)]
                                                      (values key
                                                              {:c (. opts.binh_action
                                                                     action)})))]
    (cmp.setup opts)
    (cmp.event:on :confirm_done on-confirm)
    (cmp.setup.cmdline ":"
                       {:mapping cmdline-mapping
                        :sources [{:name :cmdline :group_index 1}
                                  {:name :buffer :group_index 2}]})
    (each [_ cmd-key (ipairs ["/" "?"])]
      (cmp.setup.cmdline cmd-key
                         {:mapping cmdline-mapping
                          :sources [{:name :buffer :group_index 1}]}))))

{: opts : config}

