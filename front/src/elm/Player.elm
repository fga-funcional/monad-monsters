module Player exposing (Player, playerDecoder)

import Json.Decode as D


type alias Player =
    { playerId : Int , test : Int}


playerDecoder : D.Decoder Player
playerDecoder =
    D.map2 Player
        (D.field "playerId" D.int)
        (D.field "test" D.int)