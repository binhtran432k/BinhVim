(set vim.uv (or vim.uv vim.loop))

(fn setup [opts]
  (let [{: setup} (require :binhvim.config)]
    (setup opts)))

(fn open_workspace_recent []
  (let [current-buffer (vim.api.nvim_get_current_buf)
        current-file (vim.api.nvim_buf_get_name current-buffer)
        cwd (vim.loop.cwd)
        cwd (cwd:gsub "\\" "\\\\")]
    (each [_ file (ipairs vim.v.oldfiles)]
      (let [file-stat (vim.loop.fs_stat file)]
        (when (and file-stat (= file-stat.type :file) (not= file current-file)
                   (= (file:sub 1 (length cwd)) cwd))
          (vim.cmd (.. "edit " file))
          (lua :return))))))

{: setup : open_workspace_recent}

