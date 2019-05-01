module Image exposing (Format(..), Image, filterImages, imageListDecoder)

import Json.Decode as Decode exposing (Decoder, field, int, list, string)
import Json.Decode.Pipeline exposing (required, requiredAt)


type alias Image =
    { url : String
    , thumbnailUrl : String
    , height : Int
    , width : Int
    }


type Format
    = Portrait
    | Landscape
    | Any


imageListDecoder : Decoder (List Image)
imageListDecoder =
    field "results" (list imageDecoder)


imageDecoder : Decoder Image
imageDecoder =
    Decode.succeed Image
        |> requiredAt [ "urls", "regular" ] string
        |> requiredAt [ "urls", "thumb" ] string
        |> required "height" int
        |> required "width" int


filterImages : Format -> List Image -> List Image
filterImages format images =
    case format of
        Landscape ->
            List.filter (\image -> image.width > image.height) images

        Portrait ->
            List.filter (\image -> image.height > image.width) images

        Any ->
            images
