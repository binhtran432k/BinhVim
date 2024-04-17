(set vim.uv (or vim.uv vim.loop))

(fn setup [opts]
  (let [{: setup} (require :binhvim.config)]
    (setup opts)))

{: setup}
