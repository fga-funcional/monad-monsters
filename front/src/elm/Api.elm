module Api exposing (ApiRequest(..), get)

import Game exposing (Game, gameDecoder)
import Http
import Json.Decode as D
import Msg exposing (Msg(..))
import Player exposing (Player, playerDecoder)
import Url.Builder exposing (absolute, string)


type ApiRequest
    = Game String
    | Player String String


getGame : String -> Http.Request Game
getGame name =
    getRequest
        ("http://localhost:8000/game/" ++ name)
        gameDecoder


getPlayer : String -> String -> Http.Request Player
getPlayer g p =
    getRequest
        ("http://localhost:8000/game/" ++ g)
        playerDecoder


getRequest : String -> D.Decoder a -> Http.Request a
getRequest url decoder =
    Http.get url decoder


get : ApiRequest -> Cmd Msg
get request =
    case request of
        Game name ->
            Http.send LoadGame (getGame name)

        Player g p ->
            Http.send LoadPlayer (getPlayer g p)
