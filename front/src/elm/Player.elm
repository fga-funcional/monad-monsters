module Player exposing (Player, playerDecoder, playerListDecoder)

import Json.Decode as D


type alias Player =
    { id : Int , name : String}


playerDecoder : D.Decoder Player
playerDecoder =
    D.map2 Player
        (D.field "playerId" D.int)
        (D.field "playerName" D.string)


playerListDecoder : D.Decoder (List Player)
playerListDecoder =
    D.list playerDecoder