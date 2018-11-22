module Update exposing (update)

import Browser
import Game exposing (Game)
import Http
import Model exposing (..)
import Url
import Routing exposing (router)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChanged url ->
            -- ( { model | curUrl = url}, Cmd.none)
            ({ model | curUrl = url }, router url)

        LoadGame (Ok game) ->
            ( { model | curGame = game, error = "sem erro"}, Cmd.none )

        LoadGame (Err error) ->
            ( { model | error = Debug.toString error}, Cmd.none )

        _ ->
            ( { model | error = "sujou"}, Cmd.none )


debug : Cmd Msg
debug =
    Debug.log "adsasd"
    Cmd.none