module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, type_)
import Html.Events exposing (onInput, onSubmit)
import Http


type Msg
    = InputChanged String
    | FormSubmitted
    | ResponseReceived (Result Http.Error String)


type alias Model =
    { searchTerms : String
    , response : String
    }


init :
    ()
    -> ( Model, Cmd Msg )
init _ =
    ( { searchTerms = ""
      , response = ""
      }
    , Cmd.none
    )


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ h1 [ class "title" ] [ text "elm image search" ]
        , viewForm
        , viewResponse model
        ]


viewForm : Html Msg
viewForm =
    form [ onSubmit FormSubmitted ]
        [ input
            [ type_ "text"
            , class "medium input"
            , onInput InputChanged
            ]
            []
        ]


viewResponse : Model -> Html Msg
viewResponse model =
    div [] [ text model.response ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputChanged value ->
            ( { model | searchTerms = value }, Cmd.none )

        FormSubmitted ->
            let
                httpCommand =
                    Http.get
                        { url =
                            "https://unsplash.noprod-b.kmt.orange.com"
                                ++ "/search/photos?query="
                                ++ model.searchTerms
                        , expect = Http.expectString ResponseReceived
                        }
            in
            ( model, httpCommand )

        ResponseReceived (Ok jsonString) ->
            ( { model | response = jsonString }, Cmd.none )

        ResponseReceived (Err _) ->
            ( { model | response = "Communication error" }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
