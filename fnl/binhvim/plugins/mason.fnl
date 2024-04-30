;; cmdline tools and lsp servers installer
{1 :williamboman/mason.nvim
 :cmd [:Mason]
 :keys [{1 :<leader>cm 2 :<cmd>Mason<cr> :desc :Mason}]
 :init (fn []
         (let [mason-path (table.concat [(vim.fn.stdpath :data) :mason :bin]
                                        "/")
               os-uname (vim.uv.os_uname)
               window? (os-uname.version:match :Windows)
               path-sep (if window? ";" ":")]
           (set vim.env.PATH (table.concat [mason-path vim.env.PATH] path-sep))))
 :opts {}}

