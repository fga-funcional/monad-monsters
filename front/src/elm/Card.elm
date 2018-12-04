module Card exposing (Card, cardDecoder, cardListDecoder)

import Json.Decode as D


-- TODO: change kind to enum field
type alias Card =
    { kind : String, name : String, description : String, color : String }


cardDecoder : D.Decoder Card
cardDecoder =
    D.map4 Card
        (D.field "cardKind" D.string)
        (D.field "cardName" D.string)
        (D.field "cardDesc" D.string)
        (D.field "cardColor" D.string)

cardListDecoder : D.Decoder (List Card)
cardListDecoder =
    D.list cardDecoder