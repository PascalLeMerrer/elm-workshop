module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (type_)


view =
    div []
        [ h1 [] [ text "elm image search" ]
        , input [ type_ "text" ] []
        ]


main =
    view
