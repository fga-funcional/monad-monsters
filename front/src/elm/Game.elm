module Game exposing (Game, gameDecoder)

import Json.Decode as D
import Player exposing (Player, playerDecoder, playerListDecoder)


type alias Game =
    { id : Int, name : String, players : List Player, waiting : Bool }


gameDecoder : D.Decoder Game
gameDecoder =
    D.map4 Game
        (D.field "gameId" D.int)
        (D.field "gameName" D.string)
        (D.field "players" playerListDecoder)
        (D.field "waiting" D.bool)
