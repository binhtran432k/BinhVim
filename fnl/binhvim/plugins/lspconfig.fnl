(fn attach-keys [_ buffer]
  (macro map [key cmd {: mode & opts}]
    (set opts.buffer `buffer)
    `(vim.keymap.set ,(or mode :n) ,key ,cmd ,opts))
  (map :<leader>cl :<cmd>LspInfo<cr> {:desc "Lsp Info"})
  (map :gd
       #((. (require :telescope.builtin) :lsp_definitions) {:reuse_win true})
       {:desc "Goto Definition"})
  (map :gr "<cmd>Telescope lsp_references<cr>" {:desc :References})
  (map :gD vim.lsp.buf.declaration {:desc "Goto Declaration"})
  (map :gI #((. require :telescope.builtin) :lsp_implementations
                                            {:reuse_win true})
       {:desc "Goto Implementation"})
  (map :gy #((. require :telescope.builtin) :lsp_type_definitions
                                            {:reuse_win true})
       {:desc "Goto T[y]pe Definition"})
  (map :K vim.lsp.buf.hover {:desc :Hover :silent true})
  (map :gK vim.lsp.buf.signature_help {:desc "Signature Help"})
  (map :<c-k> vim.lsp.buf.signature_help {:mode :i :desc "Signature Help"})
  (map :<leader>ca vim.lsp.buf.code_action {:desc "Code Action" :mode [:n :v]})
  (map :<leader>cr vim.lsp.buf.rename {:desc :Rename})
  (map :<leader>cc vim.lsp.codelens.run {:desc "Run Codelens" :mode [:n :v]})
  (map :<leader>cC vim.lsp.codelens.refresh
       {:desc "Refresh & Display Codelens"})
  (map :<leader>cA
       (fn []
         (vim.lsp.buf.code_action {:context {:only [:source] :diagnostics {}}}))
       {:desc "Source Action"}))

[;; lspconfig
 {1 :neovim/nvim-lspconfig
  :event :LazyFile
  :dependencies [{1 :folke/neoconf.nvim
                  :cmd :Neoconf
                  :config false
                  :dependencies [:nvim-lspconfig]}
                 :mason.nvim]
  :opts {;; options for vim.diagnostic.config()
         :diagnostics {:underline true
                       :float {:border :rounded}
                       :update_in_insert false
                       :virtual_text {:spacing 4
                                      :source :if_many
                                      :prefix "●"
                                      ;; this will set set the prefix to a function that returns the diagnostics icon based on the severity
                                      ;; this only works on a recent 0.10.0 build. Will be set to "●" when not supported
                                      ;; :prefix "icons"
                                      }
                       :severity_sort true
                       :signs {:text {}}}
         ;; Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
         ;; Be aware that you also will need to properly configure your LSP server to
         ;; provide the inlay hints.
         :inlay_hints {:enabled false}
         ;; Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
         ;; Be aware that you also will need to properly configure your LSP server to
         ;; provide the code lenses.
         :codelens {:enabled false}
         ;; add any global capabilities here
         :capabilities {}
         ;; LSP Server Settings
         :servers {:lua_ls {;; Use this to add any additional keymaps
                            ;; for specific lsp servers
                            :settings {:Lua {:workspace {:checkThirdParty false}
                                             :codeLens {:enable true}
                                             :completion {:callSnippet :Replace}}}}}
         ;; you can do any additional lsp server setup here
         ;; return true if you don't want this server to be setup with lspconfig
         :setup {;; example to setup with typescript.nvim
                 ;; :tsserver (fn [_ opts]
                 ;;             ((. (require :typescript) :setup) {:server opts})
                 ;;             true)
                 ;; Specify * to use this function as a fallback for any server
                 ;; "*"  (fn [server opts] nil)
                 }}
  :config (fn [_ opts]
            (let [lazy-config (require :lazy.core.config)
                  plugin (. lazy-config.spec.plugins :neoconf.nvim)]
              (when (not= plugin nil)
                (let [neoconf (require :neoconf)
                      lazy-plugin (require :lazy.core.plugin)]
                  (neoconf.setup (lazy-plugin.values plugin :opts false)))))
            (var on-attachs [])
            ;; setup keymaps
            (table.insert on-attachs attach-keys)
            (let [handler :client/registerCapability
                  register-capability (. vim.lsp.handlers handler)]
              (tset vim.lsp.handlers handler
                    (fn [err res ctx]
                      (let [ret (register-capability err res ctx)
                            client (vim.lsp.get_client_by_id ctx.client_id)
                            buffer (vim.api.nvim_get_current_buf)]
                        (attach-keys client buffer)
                        ret))))
            (let [border :rounded]
              (tset vim.lsp.handlers :textDocument/hover
                    (vim.lsp.with (fn [_nil result ctx config]
                                    (when result
                                      (vim.lsp.handlers.hover _nil result ctx
                                                              config)))
                      {: border}))
              (tset vim.lsp.handlers :textDocument/signatureHelp
                    (vim.lsp.with vim.lsp.handlers.signature_help {: border})))
            ;; diagnostics signs
            (when (= (vim.fn.has :nvim-0.10.0) 0)
              (each [severity icon (pairs opts.diagnostics.signs.text)]
                (let [severity-sub (-> (. vim.diagnostic.severity severity)
                                       (: :lower)
                                       (: :gsub))
                      name (severity-sub "^%l" string.upper)
                      name (.. :DiagnosticSign name)]
                  (vim.fn.sign_define name {:text icon :texthl name :numhl ""}))))
            ;; inlay hints
            ;; (when opts.inlay_hints.enabled
            ;;   (table.insert on-attachs
            ;;                 (fn [client buffer]
            ;;                   (when (client.supports_method :textDocument/inlayHint)
            ;;                     (LazyVim.toggle.inlay_hints buffer true)))))
            ;; code lens
            (when (and opts.codelens.enabled vim.lsp.codelens)
              (table.insert on-attachs
                            (fn [client buffer]
                              (when (. client.supports_method
                                       :textDocument/codeLens)
                                (vim.lsp.codelens.refresh)
                                ;; autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
                                (vim.api.nvim_create_autocmd [:BufEnter
                                                              :CursorHold
                                                              :InsertLeave]
                                                             {: buffer
                                                              :callback vim.lsp.codelens.refresh})))))
            (vim.diagnostic.config (vim.deepcopy opts.diagnostics))
            (let [servers opts.servers
                  (has_cmp cmp_nvim_lsp) (pcall require :cmp_nvim_lsp)
                  capabilities (vim.tbl_deep_extend :force {}
                                                    (vim.lsp.protocol.make_client_capabilities)
                                                    (if has_cmp
                                                        (cmp_nvim_lsp.default_capabilities)
                                                        {})
                                                    (or opts.capabilities {}))]
              (fn setup [server]
                (let [server-opts (vim.tbl_deep_extend :force
                                                       {:capabilities (vim.deepcopy capabilities)}
                                                       (or (. servers server)
                                                           {}))
                      server-setup (if (. opts.setup server)
                                       (. opts.setup server)
                                       (. opts.setup "*")
                                       (. opts.setup "*"))
                      server-setup (if server-setup
                                       (server-setup server server-opts))]
                  (when (not server-setup)
                    (let [lspconfig (require :lspconfig)
                          {: setup} (. lspconfig server)]
                      (setup server-opts)))))

              ;; load typescript tools if it is installed
              (let [lazy-config (require :lazy.core.config)
                    plugin (. lazy-config.spec.plugins :typescript-tools.nvim)]
                (when (not= plugin nil)
                  (let [typescript (require :typescript-tools)
                        lazy-plugin (require :lazy.core.plugin)
                        plugin-opts (lazy-plugin.values plugin :opts false)]
                    (typescript.setup plugin-opts))))
              (each [server server-opts (pairs servers)]
                (when server-opts
                  (setup server))))
            ;;  if LazyVim.lsp.get_config("denols") and LazyVim.lsp.get_config("tsserver") then
            ;;    local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
            ;;    LazyVim.lsp.disable("tsserver", is_deno)
            ;;    LazyVim.lsp.disable("denols", function(root_dir)
            ;;      return not is_deno(root_dir)
            ;;    end)
            ;;  end
            ;;end
            (vim.api.nvim_create_autocmd :LspAttach
                                         {:callback (fn [args]
                                                      (let [buffer args.buf
                                                            client (vim.lsp.get_client_by_id args.data.client_id)]
                                                        (each [_ on-attach (ipairs on-attachs)]
                                                          (on-attach client
                                                                     buffer))))}))}]

