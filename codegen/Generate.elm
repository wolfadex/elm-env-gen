
module Generate exposing (main)

{-| -}

import Elm
import Elm.Annotation as Type
import Gen.CodeGen.Generate as Generate
import Gen.Helper
import Envfile
import Dict exposing (Dict)
import Parser
import String.Extra


main : Program String () ()
main =
    Generate.fromText
        (\input ->
            case Parser.run Envfile.parser input of
                Err _ ->
                    []

                Ok envVars ->
                    [ file envVars
                    ]
        )



file : Dict String String -> Elm.File
file envVars =
    envVars
        |> Dict.toList
        |> List.map
            (\( name, value ) ->
                Elm.declaration
                    (name
                        |> String.toLower
                        |> String.Extra.camelize
                        |> String.Extra.decapitalize
                    )
                    (case String.toInt value of
                        Just int ->
                            Elm.int int

                        Nothing ->
                            Elm.string value
                    )
            )
        |> Elm.file [ "Env" ]
