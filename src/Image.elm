module Image exposing (Image, imageListDecoder)

import Json.Decode as Decode exposing (Decoder, field, list, string)
import Json.Decode.Pipeline exposing (requiredAt)


type alias Image =
    { url : String
    , thumbnailUrl : String
    }


imageListDecoder : Decoder (List Image)
imageListDecoder =
    field "results" (list imageDecoder)


imageDecoder : Decoder Image
imageDecoder =
    Decode.succeed Image
        |> requiredAt [ "urls", "thumb" ] string
        |> requiredAt [ "urls", "regular" ] string
