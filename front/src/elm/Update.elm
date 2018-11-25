module Update exposing (update)

import Browser
import Browser.Navigation exposing (pushUrl, replaceUrl)
import Game exposing (Game)
import Http
import Model exposing (Model)
import Msg exposing (Msg(..))
import Pages
import Routing exposing (router, makeUrl)
import Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChanged url ->
            ( { model | curUrl = url }, router url )

        LoadGame (Ok game) ->
            ( { model | curGame = Just game, page = Pages.Player }, Cmd.none )

        LoadPlayer (Ok player) ->
            ( { model | page = Pages.Game }, Cmd.none )

        SearchGame q ->
            ( model, makeUrl [q] |> pushUrl model.key )

        AuthPlayer game playerName ->
            ( model, makeUrl [game.gameName, playerName] |> pushUrl model.key )

        ChangeSearch s ->
            ( { model | search = s }, Cmd.none )

        ChangePlayer s ->
            ( { model | playerName = s }, Cmd.none )

        _ ->
            ( { model | page = Pages.Error }, Cmd.none )
