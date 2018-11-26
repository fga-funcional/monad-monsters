module Update exposing (update)

import Browser
import Browser.Navigation exposing (pushUrl)
import Game exposing (Game)
import Http
import Model exposing (..)
import Routing exposing (router)
import Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChanged url ->
            ( { model | curUrl = url }, router url )

        LoadGame (Ok game) ->
            ( { model | curGame = Just game }, Cmd.none )

        LoadGame (Err error) ->
            ( { model | curGame = Nothing }, Cmd.none )

        SearchGame ->
            ( model, Url.toString model.curUrl ++ model.search |> pushUrl model.key )

        ChangeSearch q ->
            ( { model | search = q }, Cmd.none )

        _ ->
            ( model, Cmd.none )
