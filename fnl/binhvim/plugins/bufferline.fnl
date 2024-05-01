;; This is what powers LazyVim's fancy-looking
;; tabs, which include filetype icons and close buttons.
{1 :akinsho/bufferline.nvim
 :event :VeryLazy
 :keys [{1 :<leader>bp 2 :<cmd>BufferLineTogglePin<cr> :desc "Toggle Pin"}
        {1 :<leader>bP
         2 "<cmd>BufferLineGroupClose ungrouped<cr>"
         :desc "Delete Non-Pinned Buffers"}
        {1 :<leader>bo
         2 :<cmd>BufferLineCloseOthers<cr>
         :desc "Delete Other Buffers"}
        {1 :<leader>br
         2 :<cmd>BufferLineCloseRight<cr>
         :desc "Delete Buffers to the Right"}
        {1 :<leader>bl
         2 :<cmd>BufferLineCloseLeft<cr>
         :desc "Delete Buffers to the Left"}
        {1 :<S-h> 2 :<cmd>BufferLineCyclePrev<cr> :desc "Prev Buffer"}
        {1 :<S-l> 2 :<cmd>BufferLineCycleNext<cr> :desc "Next Buffer"}
        {1 "[b" 2 :<cmd>BufferLineCyclePrev<cr> :desc "Prev Buffer"}
        {1 "]b" 2 :<cmd>BufferLineCycleNext<cr> :desc "Next Buffer"}
        {1 "<leader>b["
         2 :<cmd>BufferLineMovePrev<cr>
         :desc "Move Buffer to Prev"}
        {1 "<leader>b]"
         2 :<cmd>BufferLineMoveNext<cr>
         :desc "Move Buffer to Next"}]
 :opts {:options {:close_command #((: (require :mini.bufremove) :delete) $1
                                                                         false)
                  :right_mouse_command #((: (require :mini.bufremove) :delete) $1
                                                                               false)
                  :diagnostics :nvim_lsp
                  :always_show_bufferline false
                  :offsets [{:filetype :neo-tree
                             :text :Neo-tree
                             :highlight :Directory
                             :text_align :left}]}}
 :config (fn [_ opts]
           (let [{: setup} (require :bufferline)]
             (setup opts)
             ;; Fix bufferline when restoring a session
             (vim.api.nvim_create_autocmd :BufAdd
                                          {:callback #(vim.schedule #(pcall nvim_bufferline))})))}

