module Game exposing (Game, game, gameDecoder, mock)

import Json.Decode as D
import Player exposing (Player, playerListDecoder)


type alias Game =
    { id : Int, name : String, players : List Player, waiting : Bool }


game : String -> Game
game name =
    Game 1 "jogo" [ Player 1 "robert" ] True


mock : Game
mock =
    Game 0 "" [ Player 0 "jhon" ] True


gameDecoder : D.Decoder Game
gameDecoder =
    D.map4 Game
        (D.field "gameId" D.int)
        (D.field "gameName" D.string)
        (D.field "players" playerListDecoder)
        (D.field "waiting" D.bool)
