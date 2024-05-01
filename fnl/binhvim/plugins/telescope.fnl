;; Fuzzy finder.
;; The default key bindings to find files will use Telescope's
;; `find_files` or `git_files` depending on whether the
;; directory is a git repo.
{1 :nvim-telescope/telescope.nvim
 :cmd :Telescope
 :version false
 :dependencies [:nvim-telescope/telescope-symbols.nvim
                {1 :nvim-telescope/telescope-fzf-native.nvim
                 :build (if (= (vim.fn.executable :make) 1) :make
                            "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build")
                 :enabled (or (= (vim.fn.executable :make) 1)
                              (= (vim.fn.executable :cmake) 1))}]
 :keys [{1 "<leader>,"
         2 "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>"
         :desc "Switch Buffer"}
        {1 :<leader>/ 2 "<cmd>Telescope live_grep<cr>" :desc :Grep}
        {1 "<leader>:"
         2 "<cmd>Telescope command_history<cr>"
         :desc "Command History"}
        {1 :<leader><space>
         2 "<cmd>Telescope find_files<cr>"
         :desc "Find Files"}
        ;; find
        {1 :<leader>fb
         2 "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>"
         :desc :Buffers}
        {1 :<leader>fg
         2 "<cmd>Telescope git_files<cr>"
         :desc "Find Files (git-files)"}
        {1 :<leader>fr
         2 "<cmd>Telescope oldfiles only_cwd=true<cr>"
         :desc :Recent}
        ;; git
        {1 :<leader>gc 2 "<cmd>Telescope git_commits<CR>" :desc :Commits}
        {1 :<leader>gs 2 "<cmd>Telescope git_status<CR>" :desc :Status}
        ;; search
        {1 "<leader>s\"" 2 "<cmd>Telescope registers<cr>" :desc :Registers}
        {1 :<leader>sa
         2 "<cmd>Telescope autocommands<cr>"
         :desc "Auto Commands"}
        {1 :<leader>sb
         2 "<cmd>Telescope current_buffer_fuzzy_find<cr>"
         :desc :Buffer}
        {1 :<leader>s* 2 "<cmd>Telescope symbols<cr>" :desc "Command Symbols"}
        {1 :<leader>sc
         2 "<cmd>Telescope command_history<cr>"
         :desc "Command History"}
        {1 :<leader>sC 2 "<cmd>Telescope commands<cr>" :desc :Commands}
        {1 :<leader>sd
         2 "<cmd>Telescope diagnostics bufnr0<cr>"
         :desc "Document Diagnostics"}
        {1 :<leader>sD
         2 "<cmd>Telescope diagnostics<cr>"
         :desc "Workspace Diagnostics"}
        {1 :<leader>sh 2 "<cmd>Telescope help_tags<cr>" :desc "Help Pages"}
        {1 :<leader>sH
         2 "<cmd>Telescope highlights<cr>"
         :desc "Search Highlight Groups"}
        {1 :<leader>sk 2 "<cmd>Telescope keymaps<cr>" :desc "Key Maps"}
        {1 :<leader>sM 2 "<cmd>Telescope man_pages<cr>" :desc "Man Pages"}
        {1 :<leader>sm 2 "<cmd>Telescope marks<cr>" :desc "Jump to Mark"}
        {1 :<leader>so 2 "<cmd>Telescope vim_options<cr>" :desc :Options}
        {1 :<leader>sR 2 "<cmd>Telescope resume<cr>" :desc :Resume}]
 :opts (fn []
         (macro find-files [opts]
           `(let [action-state# (require :telescope.actions.state)
                  line# (action-state#.get_current_line)
                  {:find_files find#} (require :telescope.builtin)]
              ,(tset opts :default_text `line#)
              (find# ,opts)))
         (let [telescope (require :telescope)
               actions (require :telescope.actions)
               open-with-trouble #((. (require :trouble.providers.telescope)
                                      :open_with_trouble) $...)
               open-selected-with-trouble #((. (require :trouble.providers.telescope)
                                               :open_selected_with_trouble) $...)
               find-files-no-ignore #(find-files {:no_ignore true})
               find-files-with-hidden #(find-files {:hidden true})]
           {:binh_onload {:fzf #(telescope.load_extension :fzf)}
            :defaults {;; open files in the first window that is an actual file.
                       ;; use the current window if no other window is available.
                       :get_selection_window (fn []
                                               (let [wins (vim.api.nvim_list_wins)
                                                     current-win (vim.api.nvim_get_current_win)]
                                                 (table.insert wins 1
                                                               current-win)
                                                 (var found-win? false)
                                                 (var found-win 0)
                                                 (each [_ win (ipairs wins)
                                                        &until found-win?]
                                                   (let [buf (vim.api.nvim_win_get_buf win)
                                                         buf-opt (. vim.bo buf)]
                                                     (when (= buf-opt.buftype
                                                              "")
                                                       (set found-win? true)
                                                       (set found-win win))))
                                                 found-win))
                       :mappings {:i {:<c-t> open-with-trouble
                                      :<a-t> open-selected-with-trouble
                                      :<a-i> find-files-no-ignore
                                      :<a-h> find-files-with-hidden
                                      :<c-down> actions.cycle_history_next
                                      :<c-up> actions.cycle_history_prev
                                      :<c-j> actions.move_selection_next
                                      :<c-k> actions.move_selection_previous
                                      :<c-d> actions.preview_scrolling_down
                                      :<c-u> actions.preview_scrolling_up}
                                  :n {:q actions.close
                                      :<c-j> actions.move_selection_next
                                      :<c-k> actions.move_selection_previous}}}}))
 :config (fn [_ opts]
           (let [{: setup} (require :telescope)]
             (setup opts))
           (each [_ onload (pairs opts.binh_onload)]
             (onload)))}

