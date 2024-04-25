{:init #(let [mason-path (table.concat [(vim.fn.stdpath :data) :mason :bin] "/")
              os-uname (vim.uv.os_uname)
              window? (os-uname.version:match :Windows)
              path-sep (if window? ";" ":")]
          (set vim.env.PATH (table.concat [mason-path vim.env.PATH] path-sep)))
 :opts #{}}

