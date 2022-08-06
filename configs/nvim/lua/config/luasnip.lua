local ls = require('luasnip')

ls.snippets = {
    all = {
    },

    cpp = {
        ls.parser.parse_snippet(
            "fd",
            "/**\n * @brief $0\n *\n */\nauto $1($2) -> $3;\n"
        ),
        ls.parser.parse_snippet(
            "fi",
            "auto $1($2) -> $3\n{\n    $0\n}\n"
        ),
        ls.parser.parse_snippet(
            "fs",
            "/**\n * @brief $4\n *\n */\nstatic auto $1($2) -> $3\n{\n    $0\n}\n"
        ),
    },
    
    typescriptreact = {
        ls.parser.parse_snippet(
            "fc",
            "interface $1Props {}\n\nconst $1: React.FC<$1Props> = (props) {\n  return <></>;\n}\n\nexport default $1"
        )
    }
}

