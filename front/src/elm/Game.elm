module Game exposing (Game, game, mock, gameDecoder)

import Json.Decode as D

import Player exposing (Player, playerListDecoder)

type alias Game =
    { gameId : Int, gameName : String, players : List Player }


game : String -> Game
game name =
    Game 1 "jogo" [(Player 1 2)]


mock : Game
mock = 
    Game 0 "" [(Player 0 0)]


gameDecoder : D.Decoder Game
gameDecoder =
    D.map3 Game
        (D.field "gameId" D.int)
        (D.field "gameName" D.string)
        (D.field "players" playerListDecoder)