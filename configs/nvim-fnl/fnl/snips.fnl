(import-macros {: plugin-setup} :util-macros)

;; fnlfmt: skip
(let [parse (. (require :luasnip) :parser.parse_snippet)]
  (plugin-setup :luasnip {:snippets {
	:cpp [
	  [:fd "/**\n * @brief $0\n *\n */\nauto $1($2) -> $3;\n"]
          [:fi "auto $1($2) -> $3\n{\n    $0\n}\n"]
          [:fs "/**\n * @brief $4\n *\n */\nstatic auto $1($2) -> $3\n{\n    $0\n}\n"]
	]
        :typescriptreact [
	  [:fc "interface $1Props {}\n\nconst $1: React.FC<$1Props> = (props) {\n  return <></>;\n}\n\nexport default $1"
	  ]
	]}}))
