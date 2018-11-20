module Game exposing (Game, game, mock, gameDecoder)

import Json.Decode as D

import Player exposing (Player, playerDecoder)

type alias Game =
    { gameId : Int, playerTurn : Bool, player : Player }


game : String -> Game
game name =
    Game 1 False (Player 1)


mock : Game
mock = 
    Game 0 False (Player 0)


gameDecoder : D.Decoder Game
gameDecoder =
    D.map3 Game
        (D.field "gameId" D.int)
        (D.field "playerTurn" D.bool)
        (D.field "player" playerDecoder)