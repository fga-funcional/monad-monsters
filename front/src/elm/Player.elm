module Player exposing (Player, playerDecoder, playerListDecoder)

import Card exposing (Card, cardListDecoder)
import Json.Decode as D


type alias Player =
    { id : Int, name : String, cards : List Card }


playerDecoder : D.Decoder Player
playerDecoder =
    D.map3 Player
        (D.field "playerId" D.int)
        (D.field "playerName" D.string)
        (D.field "playerCards" cardListDecoder)


playerListDecoder : D.Decoder (List Player)
playerListDecoder =
    D.list playerDecoder
