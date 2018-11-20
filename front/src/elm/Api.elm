module Api exposing (getNewGame, getRequest, sendRequest)

import Game exposing (Game, gameDecoder)
import Http
import Json.Decode as D
import Model exposing (Msg(..))


getNewGame : Http.Request Game
getNewGame =
    -- getRequest2
    getRequest
    "http://localhost:8000/newgame"
    gameDecoder


getRequest : String -> D.Decoder a -> Http.Request a
getRequest url decoder =
    Http.get url decoder


sendRequest : Cmd Msg
sendRequest =
    Debug.log "entrou"
        Http.send
        LoadGame
        getNewGame


getRequest2 : Http.Request Game
getRequest2 =
    Http.request
        { method = "GET"
        , url = "http://localhost:8000/newgame"
        , headers = [ Http.header "Access-Control-Allow-Origin" "*"  ]
        , body = Http.emptyBody
        , expect = Http.expectJson gameDecoder
        , timeout = Nothing
        , withCredentials = False
        }
