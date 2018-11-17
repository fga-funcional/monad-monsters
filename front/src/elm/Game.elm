module Game exposing (Game, game, mock)

import Player exposing (Player)


type alias Game =
    { gameId : Int, playerTurn : Bool, player : Player }


game : String -> Game
game name =
    Game 1 False (Player 1)


mock : Game
mock = 
    Game 0 False (Player 0)