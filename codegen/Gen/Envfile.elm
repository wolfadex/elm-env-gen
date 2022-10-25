module Gen.Envfile exposing (call_, encode, moduleName_, parser, values_)

{-| 
@docs values_, call_, parser, encode, moduleName_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Envfile" ]


{-| Take a `Dict String String`, ignore the keys that bash wouldn’t interpret as
a variable name and encode the rest as variable declarations, one on each line.

    import Dict

    [ ("hello", "world")
    , ("_john", "_WAYNE")
    , ("234notavar", "Won’t be encoded")
    , ("also not a var", "Also won’t be encoded")
    , ("thing1", "thing\n2")
    ]
        |> Dict.fromList
        |> encode
        |> String.lines
        |> List.sort
    --> [ "_john=_WAYNE"
    --> , "hello=world"
    --> , "thing1=thing\\n2"
    --> ]

encode: Dict.Dict String String -> String
-}
encode : Elm.Expression -> Elm.Expression
encode encodeArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Envfile" ]
            , name = "encode"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.string, Type.string ]
                        ]
                        Type.string
                    )
            }
        )
        [ encodeArg ]


{-| A `Parser` to read an envfile as a `Dict String String`.

    import Parser
    import Dict

    Parser.run parser <| String.join "\n"
        [ "hello=world"
        , "# this is a comment"
        , ""
        , ""
        , "_abc=def\\nghi"
        ]
    --> Ok (Dict.fromList [ ("_abc", "def\nghi") , ("hello", "world") ])

parser: Parser.Parser (Dict.Dict String String)
-}
parser : Elm.Expression
parser =
    Elm.value
        { importFrom = [ "Envfile" ]
        , name = "parser"
        , annotation =
            Just
                (Type.namedWith
                    [ "Parser" ]
                    "Parser"
                    [ Type.namedWith
                        [ "Dict" ]
                        "Dict"
                        [ Type.string, Type.string ]
                    ]
                )
        }


call_ : { encode : Elm.Expression -> Elm.Expression }
call_ =
    { encode =
        \encodeArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Envfile" ]
                    , name = "encode"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.string, Type.string ]
                                ]
                                Type.string
                            )
                    }
                )
                [ encodeArg ]
    }


values_ : { encode : Elm.Expression, parser : Elm.Expression }
values_ =
    { encode =
        Elm.value
            { importFrom = [ "Envfile" ]
            , name = "encode"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.string, Type.string ]
                        ]
                        Type.string
                    )
            }
    , parser =
        Elm.value
            { importFrom = [ "Envfile" ]
            , name = "parser"
            , annotation =
                Just
                    (Type.namedWith
                        [ "Parser" ]
                        "Parser"
                        [ Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.string, Type.string ]
                        ]
                    )
            }
    }


