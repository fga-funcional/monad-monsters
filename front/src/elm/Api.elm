module Api exposing (get, ApiRequest(..))

import Game exposing (Game, gameDecoder)
import Http
import Json.Decode as D
import Model exposing (Msg(..))
import Url.Builder exposing (absolute, string)


type ApiRequest
    = Game String
    | Player


getNewGame : Http.Request Game
getNewGame =
    -- getRequest2
    getRequest
        "http://localhost:8000/newgame"
        gameDecoder


getGame : String -> Http.Request Game
getGame name =
    getRequest
        ("http://localhost:8000/game/" ++ name) 
        gameDecoder


getRequest : String -> D.Decoder a -> Http.Request a
getRequest url decoder =
    Http.get url decoder


get : ApiRequest -> Cmd Msg
get api =
    case api of
        Game name ->
            Http.send LoadGame (getGame name)
        Player ->
            Cmd.none
