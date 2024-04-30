;; snippets
{1 :garymjr/nvim-snippets
 :dependencies :rafamadriz/friendly-snippets
 :keys [{1 :<tab>
         2 (fn []
             (if (vim.snippet.jumpable 1)
                 (vim.schedule #(vim.snippet.jump 1))
                 :<tab>))
         :expr true
         :silent true
         :mode :i}
        {1 :<tab>
         2 (fn []
             (vim.schedule #(vim.snippet.jump 1)))
         :expr true
         :silent true
         :mode :s}
        {1 :<s-tab>
         2 (fn []
             (if (vim.snippet.jumpable -1)
                 (vim.schedule #(vim.snippet.jump -1))
                 :<s-tab>))
         :expr true
         :silent true
         :mode [:i :s]}]
 :opts {:friendly_snippets true}}

