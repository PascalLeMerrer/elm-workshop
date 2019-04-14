module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, type_)
import Html.Events exposing (onInput)


type alias Model =
    String


type Msg
    = InputChanged String


initialModel : String
initialModel =
    ""


view :
    Model
    -> Html Msg -- 1
view model =
    div [ class "container" ]
        [ h1 [ class "title" ] [ text "elm image search" ]
        , input
            [ type_ "text"
            , class "medium input"
            , onInput InputChanged
            ]
            []
        ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        InputChanged value ->
            value


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
