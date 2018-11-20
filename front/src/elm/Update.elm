module Update exposing (update)

import Api exposing (sendRequest)
import Browser
import Game exposing (Game)
import Http
import Model exposing (..)
import Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChanged url ->
            ( { model | curUrl = url}, Cmd.none)
            -- update (MakeGetRequest "http://localhost:8000/newgame") { model | curUrl = url }

        LoadGame (Ok game) ->
            ( { model | curGame = game, error = "sem erro"}, Cmd.none )

        LoadGame (Err error) ->
            ( { model | error = "vish" }, Cmd.none )

        MakeGetRequest url ->
            ({model | error = "aaaa"}, sendRequest)
        _ ->
            ( { model | error = "sujou"}, Cmd.none )


debug : Cmd Msg
debug =
    Debug.log "adsasd"
    Cmd.none