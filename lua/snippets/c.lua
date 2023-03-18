return {
    s({ trig = "sst", name = "Standard Template" }, fmt([[
        #include <stdlib.h>
        #include <stdio.h>

        int main(int argc, char *argv[]) {{
            {}
            return EXIT_SUCCESS;
        }}
    ]], { i(0) })),
    s({ trig = "sstp", name = "Preprocessor Template" }, fmt([[
        // #define NDEBUG // disables assert()
        #include <stdlib.h>
        #include <stddef.h>
        #include <stdbool.h>
        #include <assert.h>
        #include <errno.h>
        #include <stdio.h>

    ]], {})),
    s({ trig = "main", name = "main(int argc, char *argv[])" }, fmt([[
        int main(int argc, char *argv[]) {{
            {}
            return EXIT_SUCCESS;
        }}
    ]], { i(0) })),
    s({ trig = "mainn", name = "main(void)" }, fmt([[
        int main(void) {{
            {}
            return EXIT_SUCCESS;
        }}
    ]], { i(0) })),
    s({ trig = "#inc", name = "#include <...>" }, fmt([[
        #include <{}>
    ]], { i(1) })),
    s({ trig = "#inc", name = "#include \"...\"" }, fmt([[
        #include "{}"
    ]], { i(1) })),
    s({ trig = "#def", name = "#define macro" }, fmt([[
        #define {}
    ]], { i(0) })),
    s({ trig = "#deff", name = "#define macro()" }, fmt([[
        #define {}({}) ({})
    ]], { i(1), i(2), i(3) })),
    s({ trig = "#if", name = "#if" }, fmt([[
        #if {}
        {}
        #endif /* if {} */
    ]], { i(1), i(0), reference(1) })),
    s({ trig = "#ifdef", name = "#ifdef" }, fmt([[
        #ifdef {}
        {}
        #endif /* ifdef {} */
    ]], { i(1), i(0), reference(1) })),
    s({ trig = "#ifndef", name = "#ifndef" }, fmt([[
        #ifndef {}
        {}
        #endif /* ifndef {} */
    ]], { i(1), i(0), reference(1) })),
    s({ trig = "once", name = "Header Include Guard" }, fmt([[
        #ifndef {}_H
        #define {}_H
        {}
        #endif /* end of include guard: {} */
    ]], { i(1), reference(1), i(0), reference(1) })),
    s({ trig = "nocpp", name = "extern C", dscr = "Disable C++ name mangling in C headers" }, fmt([[
        #ifdef __cplusplus
        extern "C" {{
        #endif
        {}
        #ifdef __cplusplus
        }} /* extern "C" */
        #endif
    ]], { i(0) })),
    s({ trig = "#err", name = "#error" }, fmt([[
        #error "{}"
    ]], { i(1) })),
    s({ trig = "#warn", name = "#warning" }, fmt([[
        #warning "{}"
    ]], { i(1) })),
    s({ trig = "if", name = "if" }, fmt([[
        if ({}) {{
            {}
        }}
    ]], { i(1), i(0) })),
    s({ trig = "ife", name = "if else" }, fmt([[
        if ({}) {{
            {}
        }} else {{
            {}
        }}
    ]], { i(1), i(2), i(0) })),
    s({ trig = "el", name = "else" }, fmt([[
        else {{
            {}
        }}
    ]], { i(0) })),
    s({ trig = "elif", name = "else if" }, fmt([[
        else if ({}) {{
            {}
        }}
    ]], { i(1), i(0) })),
    s({ trig = "t", name = "Ternary" }, fmt([[
        {} ? {} : {}
    ]], { i(1), i(2), i(0) })),
    s({ trig = "switch", name = "Switch" }, fmt([[
        switch ({}) {{
            {}
            default:
                {}
        }}
    ]], { i(1), i(0), i(2) })),
    s({ trig = "switchn", name = "Switch Without Default" }, fmt([[
        switch ({}) {{
            {}
        }}
    ]], { i(1), i(0) })),
    s({ trig = "case", name = "Case" }, fmt([[
        case {}:
            {}
    ]], { i(1), i(0) })),
    s({ trig = "while", name = "While" }, fmt([[
        while ({}) {{
            {}
        }}
    ]], { i(1), i(0) })),
    s({ trig = "do", name = "Do While" }, fmt([[
        do {{
            {}
        }} while({});
    ]], { i(0), i(1) })),
    s({ trig = "for", name = "For" }, fmt([[
        for ({}) {{
            {}
        }}
    ]], { i(1), i(0) })),
    s({ trig = "ret", name = "return" }, fmt([[
        return {};
    ]], { i(1) })),
    s({ trig = "ex", name = "exit()" }, fmt([[
        exit({});
    ]], { i(1) })),
    s({ trig = "fund", name = "Function Declaration" }, fmt([[
        {}({});
    ]], { i(1), i(2) })),
    s({ trig = "fun", name = "Function Definition" }, fmt([[
        {}({}) {{
            {}
        }}
    ]], { i(1), i(2), i(0) })),
    s({ trig = "td", name = "typedef" }, fmt([[
        typedef {};
    ]], { i(1) })),
    s({ trig = "tdst", name = "typedef struct" }, fmt([[
        typedef struct {} {};
    ]], { reference(1), i(1) })),
    s({ trig = "tduo", name = "typedef union" }, fmt([[
        typedef union {} {};
    ]], { reference(1), i(1) })),
    s({ trig = "tden", name = "typedef enum" }, fmt([[
        typedef enum {} {};
    ]], { reference(1), i(1) })),
    s({ trig = "st", name = "Struct" }, fmt([[
        struct {} {{
            {}
        }};
    ]], { i(1), i(0) })),
    s({ trig = "stt", name = "Struct Type" }, fmt([[
        typedef struct {} {{
            {}
        }} {};
    ]], { i(1), i(0), reference(1) })),
    s({ trig = "uo", name = "Union" }, fmt([[
        union  {} {{
            {}
        }};
    ]], { i(1), i(0) })),
    s({ trig = "uot", name = "Union Type" }, fmt([[
        typedef union {} {{
            {}
        }} {};
    ]], { i(1), i(0), reference(1) })),
    s({ trig = "enum", name = "Enum" }, fmt([[
        enum {} {{
            {}
        }};
    ]], { i(1), i(0) })),
    s({ trig = "enumt", name = "Enum Type" }, fmt([[
        typedef enum {} {{
            {}
        }} {};
    ]], { i(1), i(0), reference(1) })),
    s({ trig = "pri", name = "printf()" }, fmt([[
        printf("{}\n", {});
    ]], { i(1, "%s"), i(2) })),
    s({ trig = "fpri", name = "fprintf()" }, fmt([[
        fprintf({}, "{}\n", {});
    ]], { i(1, "stderr"), i(2, "%s"), i(3) })),
    s({ trig = "spri", name = "sprintf()" }, fmt([[
        sprintf({}, "{}\n", {});
    ]], { i(1, "buf"), i(2, "%s"), i(3) })),
    s({ trig = "snpri", name = "snprintf()" }, fmt([[
        snprintf({}, {}, "{}\n", {});
    ]], { i(1, "buf"), i(2, "max"), i(3, "%s"), i(4) })),
    s({ trig = "sca", name = "scanf()" }, fmt([[
        scanf("{}", {});
    ]], { i(1, "%i"), i(2) })),
    s({ trig = "fsca", name = "fscanf()" }, fmt([[
        fscanf({}, "{}", {});
    ]], { i(1, "stdin"), i(2, "%i"), i(3) })),
    s({ trig = "ssca", name = "sscanf()" }, fmt([[
        sscanf({}, "{}", {});
    ]], { i(1, "buf"), i(2, "%i"), i(3) })),
    s({ trig = "priv", name = "Print Variable" }, fmt([[
        printf("{} = {}\n", {});
    ]], { reference(2), i(1, "%i"), i(2) })),
    s({ trig = "warn", name = "warn()" }, fmt([[
        warn("{}"{});
    ]], { i(1, "%s"), i(2) })),
    s({ trig = "warnx", name = "warnx()" }, fmt([[
        warnx("{}"{});
    ]], { i(1, "%s"), i(2) })),
    s({ trig = "err", name = "err()" }, fmt([[
        err("{}"{});
    ]], { i(1, "%s"), i(2) })),
    s({ trig = "errx", name = "errx()" }, fmt([[
        errx("{}"{});
    ]], { i(1, "%s"), i(2) })),
    s({ trig = "asr", name = "assert()" }, fmt([[
        assert({});
    ]], { i(1) })),
    s({ trig = "stasr", name = "static_assert()" }, fmt([[
        static_assert({}, "{}");
    ]], { i(1), i(2, "Fuck!") })),
    s({ trig = "Stasr", name = "static_assert() 1 Parameter" }, fmt([[
        static_assert({});
    ]], { i(1) })),
    s({ trig = "mlc", name = "malloc()" }, fmt([[
        {} = malloc(sizeof({}[{}]){});
    ]], { i(1, "ptr"), i(2, "int"), i(3), i(4) })),
    s({ trig = "clc", name = "calloc()" }, fmt([[
        {} = calloc({}, sizeof({}){});
    ]], { i(1, "ptr"), i(2), i(3, "int"), i(4) })),
    s({ trig = "rlc", name = "realloc()" }, fmt([[
        {} = realloc({}, sizeof({}[{}]){});
    ]], { i(1, "ptr"), i(2), i(3, "int"), i(4), i(5) })),
    s({ trig = "fre", name = "free()" }, fmt([[
        free({});
    ]], { i(1, "ptr") })),
    s({ trig = "mlcd", name = "Malloc Declaration" }, fmt([[
        {} *{} = malloc(sizeof({}[{}]){});
    ]], { i(1, "int"), i(2, "ptr"), reference(1), i(3), i(4) })),
    s({ trig = "clcd", name = "Calloc Declaration" }, fmt([[
        {} *{} = calloc({}, sizeof({}){});
    ]], { i(1, "int"), i(2, "ptr"), i(3), reference(1), i(4) })),
    s({ trig = "mlct", name = "Malloc Template" }, fmt([[
        {} *{} = malloc(sizeof({}[{}]));
        if (!{}) {{
            printf(stderr, "{}\n"{});
            {}
        }}
        {}
        free({});
    ]], { i(1, "int"), i(2, "ptr"), reference(1), i(3), reference(2), i(4, "Failed to malloc!"), i(5),
        i(6, "exit(EXIT_FAILURE);"), i(0), reference(2) })),
    s({ trig = "clct", name = "Calloc Template" }, fmt([[
        {} *{} = calloc({}, sizeof({}));
        if (!{}) {{
            printf(stderr, "{}\n"{});
            {}
        }}
        {}
        free({});
    ]], { i(1, "int"), i(2, "ptr"), i(3), reference(1), reference(2), i(4, "Failed to calloc!"), i(5),
        i(6, "exit(EXIT_FAILURE);"), i(0), reference(2) })),
    s({ trig = "/", name = "Comment" }, fmt([[
        /* {} */
    ]], { i(1) })),
    s({ trig = "//", name = "Multiline Comment" }, fmt([[
        /*
         * {}
         */
    ]], { i(1) })),
    s({ trig = "///", name = "Multiline Double-Star Comment" }, fmt([[
        /**
         ** {}
         **/
    ]], { i(1) })),
    s({ trig = "dox", name = "Doxygen Template" }, fmt([[
        /*! {}
         * @brief {}
         *
         * {}
         */
    ]], { i(1), i(2, "This is something undocumented."), i(3, "Nothing to say here...") })),
    s({ trig = "dfun", name = "Doxygen Function" }, fmt([[
        /*!
         * @brief {}
         *
         * {}
         *
         * @return {}
         */
         {}({});
    ]], { i(3, "This function is undocumented."), i(4, "Nothing to say here..."), i(5, "Nothing."), i(1), i(2) })),
    s({ trig = "todo", name = "Doxygen Todo" }, fmt([[
        /*! TODO: {}
         *
         * @todo {}
         */
    ]], { i(1), i(2) })),
    s({ trig = "dgr", name = "Doxygen Group" }, fmt([[
        /*! @name {}
         * {}
         * @{{
         */
        {}
        /*! @}}
         */
    ]], { i(1, "Undocumented Group"), i(2, "This group is undocumented."), i(0) })),
    s({ trig = "alen", name = "Array Length" }, fmt([[
        (sizeof {} / sizeof {}[0])
    ]], { i(1), reference(1) })),
    s({ trig = "lls", name = "Linked List" }, fmt([[
        struct {} {{
            {}
            {} *{};
        }} {};
    ]], { i(1, "Node"), i(0), reference(1), i(2, "Next"), reference(1) })),
}
