(local prettier? (. (vim.fs.find [;; https://prettier.io/docs/en/configuration.html
                                  :.prettierrc
                                  :.prettierrc.json
                                  :.prettierrc.yml
                                  :.prettierrc.yaml
                                  :.prettierrc.json5
                                  :.prettierrc.js
                                  :.prettierrc.cjs
                                  :.prettierrc.toml
                                  :prettier.config.js
                                  :prettier.config.cjs]
                                 {:upward true}) 1))

(local biome? (. (vim.fs.find [:biome.json] {:upward true}) 1))

(macro format [opts]
  (tset opts :timeout_ms 3000)
  (tset opts :async false) ; not recommended to change
  (tset opts :quiet false) ; not recommended to change
  (tset opts :lsp_fallback true) ; not recommended to change
  (tset opts :filter `filter-client)
  `((. (require :conform) :format) ,opts))

(macro contain [lst obj]
  `(and ,(unpack (icollect [_ item (ipairs lst)]
                   `(not= ,obj ,item)))))

(fn filter-client [{: name}]
  (if biome?
      (contain [:jsonls :tsserver :typescript-tools] name) true))

;; formatter
{1 :stevearc/conform.nvim
 :cmd :ConformInfo
 :keys [{1 :<leader>cf 2 #(format {}) :mode [:n :v] :desc :Format}
        {1 :<leader>cF
         2 #(format {:formatters [:injected]})
         :mode [:n :v]
         :desc "Format Injected Langs"}]
 :opts {:formatters_by_ft {:fennel [:fnlfmt]
                           :lua [:stylua]
                           :fish [:fish_indent]
                           :sh [:shfmt]}}}

