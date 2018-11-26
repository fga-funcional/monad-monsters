module Player exposing (Player, playerDecoder)

import Json.Decode as D


type alias Player =
    { playerId : Int }


playerDecoder : D.Decoder Player
playerDecoder =
    D.map Player
        (D.field "playerId" D.int)
