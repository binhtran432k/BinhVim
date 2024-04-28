(fn opts []
  (let [ai (require :mini.ai)
        ai-open (ai.gen_spec.treesitter {:a ["@block.outer"
                                             "@conditional.outer"
                                             "@loop.outer"]
                                         :i ["@block.inner"
                                             "@conditional.inner"
                                             "@loop.inner"]}
                                        {})
        ai-func (ai.gen_spec.treesitter {:a "@function.outer"
                                         :i "@function.inner"}
                                        {})
        ai-cls (ai.gen_spec.treesitter {:a "@class.outer" :i "@class.inner"} {})
        ai-tag ["<([%p%w]-)%f[^<%w][^<>]->.-</%1>" "^<.->().*()</[^/]->$"]
        ai-digit ["%f[%d]%d+"]
        ai-word [["%u[%l%d]+%f[^%l%d]"
                  "%f[%S][%l%d]+%f[^%l%d]"
                  "%f[%P][%l%d]+%f[^%l%d]"
                  "^[%l%d]+%f[^%l%d]"]
                 "^().*()$"]
        ai-global (fn []
                    (let [from {:line 1 :col 1}
                          to {:line (vim.fn.line "$")
                              :col (math.max (: (vim.fn.getline "$") :len) 1)}]
                      {: from : to}))
        ai-usage (ai.gen_spec.function_call)
        ai-usage-nodot (ai.gen_spec.function_call {:name_pattern "[%w_]"})]
    {:n_lines 500
     :custom_textobjects {:o ai-open
                          :f ai-func
                          :c ai-cls
                          :t ai-tag
                          ;; digits
                          :d ai-digit
                          ;; Word with case
                          :e ai-word
                          ;; Whole buffer, similar to `gg` and 'G' motion
                          :g ai-global
                          ;; u for "Usage"
                          :u ai-usage
                          ;; without dot in function name
                          :U ai-usage-nodot}}))

(fn config [_ opts]
  (let [{: setup} (require :mini.ai)]
    (setup opts)))

(fn wk_opts [_ opts]
  (local i {" " :Whitespace
            "\"" "Balanced \""
            "'" "Balanced '"
            "`" "Balanced `"
            "(" "Balanced ("
            ")" "Balanced ) including white-space"
            :> "Balanced > including white-space"
            :<lt> "Balanced <"
            "]" "Balanced ] including white-space"
            "[" "Balanced ["
            "}" "Balanced } including white-space"
            "{" "Balanced {"
            :? "User Prompt"
            :_ :Underscore
            :a :Argument
            :b "Balanced ), ], }"
            :c :Class
            :d "Digit(s)"
            :e "Word in CamelCase & snake_case"
            :f :Function
            :g "Entire file"
            :o "Block, conditional, loop"
            :q "Quote `, \", '"
            :t :Tag
            :u "Use/call function & method"
            :U "Use/call without dot in name"})
  (local a (collect [k v (pairs i)]
             (values k (v:gsub " including.*" ""))))
  (local ic (vim.deepcopy i))
  (local ac (vim.deepcopy a))
  (macro set-next-last []
    `(do
       ,(unpack (icollect [key name (pairs {:n :Next :l :Last})]
                  `(do
                     (tset i ,key
                           (vim.tbl_extend :force
                                           {:name ,(.. "Inside " name
                                                       " textobject")}
                                           ic))
                     (tset a ,key
                           (vim.tbl_extend :force
                                           {:name ,(.. "Around " name
                                                       " textobject")}
                                           ac)))))))
  (set-next-last)
  (let [new-opts {:binh_register {:ai {:mode [:o :x] : i : a}}}]
    (vim.tbl_deep_extend :force opts new-opts)))

{: opts : config : wk_opts}

