(import-macros {: plugin-setup} :util-macros)

(let [default-opts {:noremap true :silent true}
      expr_opts {:noremap true :expr true :silent true}]
  (plugin-setup :legendary
                {:keymaps [{1 :<c-h>
                            2 :<c-w>h
                            :mode [:n]
                            :description "move focus left"
                            :opts default-opts}
                           {1 :<c-j>
                            2 :<c-w>j
                            :mode [:n]
                            :description "move focus down"
                            :opts default-opts}
                           {1 :<c-k>
                            2 :<c-w>k
                            :mode [:n]
                            :description "move focus up"
                            :opts default-opts}
                           {1 :<c-l>
                            2 :<c-w>l
                            :mode [:n]
                            :description "move focus right"
                            :opts default-opts}
                           {1 :<c-t>
                            2 "<cmd>ToggleTerm size=20<cr>"
                            :mode [:n]
                            :description "toggle terminal"
                            :opts default-opts}
                           {1 "<"
                            2 :<gv
                            :mode [:v]
                            :description "unindent selection"
                            :opts default-opts}
                           {1 ">"
                            2 :>gv
                            :mode [:v]
                            :description "indent selection"
                            :opts default-opts}
                           {1 :Y
                            2 :y$
                            :mode [:n]
                            :description "yank to end of line"
                            :opts default-opts}
                           {1 :P
                            2 :_dP
                            :mode [:v]
                            :description "paste over selected text"
                            :opts default-opts}
                           {1 :n
                            2 :nzz
                            :mode [:n]
                            :description "next result (center)"
                            :opts default-opts}
                           {1 :N
                            2 :Nzz
                            :mode [:n]
                            :description "prev result (center)"
                            :opts default-opts}
                           {1 :<esc>
                            2 ":nohlsearch<bar>:echo<cr>"
                            :mode [:n]
                            :description "cancel search highlight"
                            :opts default-opts}
                           {1 :J
                            2 ":m '>+1<cr>gv-gc"
                            :mode [:v]
                            :description "move lines downward"
                            :opts default-opts}
                           {1 :K
                            2 ":m '<-2<cr>gv-gc"
                            :mode [:v]
                            :description "move lines upward"
                            :opts default-opts}
                           {1 :j
                            2 "v:count == 0 ? 'gj' : 'j'"
                            :mode [:n]
                            :description "move down accross visual lines"
                            :opts expr_opts}
                           {1 :k
                            2 "v:count == 0 ? 'gk' : 'k'"
                            :mode [:n]
                            :description "move up accross visual lines"
                            :opts expr_opts}
                           {1 :jk
                            2 "<c-\\\\><c-n>"
                            :mode [:t]
                            :description "leave insert mode (terminal)"
                            :opts default-opts}
                           {1 :<a-j>
                            2 :<cmd>BufferPrevious<cr>
                            :mode [:n]
                            :description "prev buffer"
                            :opts default-opts}
                           {1 :<a-k>
                            2 :<cmd>BufferNext<cr>
                            :mode [:n]
                            :description "next buffer"
                            :opts default-opts}
                           {1 :<a-<>
                            2 :<cmd>BufferMovePrevious<cr>
                            :mode [:n]
                            :description "move buffer prev"
                            :opts default-opts}
                           {1 :<a->>
                            2 :<cmd>BufferMoveNext<cr>
                            :mode [:n]
                            :description "move buffer next"
                            :opts default-opts}
                           {1 :<a-x>
                            2 :<cmd>BufferClose<cr>
                            :mode [:n]
                            :description "close buffer"
                            :opts default-opts}]
                 :autocmds [{1 :FileType
                             2 "set commentstring=//%s"
                             :opts {:pattern [:*.c :*.cpp]}
                             :description "set commentstring for C and C++"}
                            {1 :TextYankPost
                             2 "lua vim.highlight.on_yank {on_visual = false}"
                             :description "highlight yanked text"}
                            {1 [:BufNewFile :BufRead]
                             2 "set filetype=fsharp"
                             :opts {:pattern [:*.fs "*.fs{x,i}"]}
                             :description "open diagnostics on holding the cursor"}
                            {1 [:BufNewFile :BufRead]
                             2 "set filetype=markdown"
                             :opts {:pattern [:*.mdx]}
                             :description "set filetype to markdown for *.mdx"}
                            {1 [:BufNewFile :BufRead]
                             2 "set filetype=astro"
                             :opts {:pattern [:*.astro]}
                             :description "set filetype to astro for *.astro"}]}))
