module Api exposing (ApiRequest(..), get)

import Game exposing (Game, gameDecoder)
import Http
import Json.Decode as D
import Msg exposing (Msg(..))
import Player exposing (Player, playerDecoder)
import Url.Builder exposing (absolute, string)


type ApiRequest
    = CreateGame String
    | EnterGame String String
    | Game String


getNewGame : String -> Http.Request Game
getNewGame name =
    getRequest
        (buildStringUrl "http://localhost:8000/" ["games", name])
        gameDecoder


getGame : String -> Http.Request Game
getGame name =
    getRequest
        (buildStringUrl "http://localhost:8000/" [name])
        gameDecoder


getPlayer : String -> String -> Http.Request Game
getPlayer g p =
    getRequest
        (buildStringUrl "http://localhost:8000/" ["players", g, p])
        gameDecoder


getRequest : String -> D.Decoder a -> Http.Request a
getRequest url decoder =
    Http.get url decoder


get : ApiRequest -> Cmd Msg
get request =
    case request of
        Game name ->
            Http.send LoadCurGame (getGame name)

        CreateGame name ->
            Http.send LoadGame (getNewGame name)

        EnterGame g p ->
            Http.send LoadPlayer (getPlayer g p)


buildStringUrl : String -> List String -> String
buildStringUrl base params =
    base ++ String.join "/" params