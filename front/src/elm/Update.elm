module Update exposing (update)

import Api
import Browser
import Browser.Navigation exposing (pushUrl, replaceUrl)
import Game exposing (Game)
import Http
import Model exposing (Model)
import Msg exposing (Msg(..))
import Pages
import Player exposing (Player)
import Routing exposing (makeUrl, playerNameFromUrl, router)
import Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChanged url ->
            ( { model | curUrl = url }, router url )

        LoadCurGame (Ok game) ->
            ( { model | curGame = Just game }, Cmd.none )

        LoadCurGame (Err err) ->
            ( { model | page = Pages.ErrorWithMsg <| Debug.toString err }, Cmd.none )

        LoadGame (Ok game) ->
            ( { model | curGame = Just game, page = Pages.Player }, Cmd.none )

        LoadGame (Err err) ->
            ( { model | curGame = Nothing, page = Pages.ErrorWithMsg <| Debug.toString err }, Cmd.none )

        LoadPlayer (Ok game) ->
            ( { model | curGame = Just game, curPlayer = setPlayer game.players model, page = Pages.Game }, Cmd.none )

        LoadPlayer (Err err) ->
            ( { model | curGame = Nothing, page = Pages.ErrorWithMsg <| Debug.toString err }, Cmd.none )

        SearchGame q ->
            ( model, makeUrl [ q ] |> pushUrl model.key )

        AuthPlayer game playerName ->
            ( model, makeUrl [ game.name, playerName ] |> pushUrl model.key )

        ChangeSearch s ->
            ( { model | search = s }, Cmd.none )

        ChangePlayer s ->
            ( { model | playerName = s }, Cmd.none )

        UpdateGame t ->
            case model.curGame of
                Nothing ->
                    ( model, Cmd.none )

                Just game ->
                    ( model, Api.get (Api.Game game.name) )

        _ ->
            ( { model | page = Pages.Error }, Cmd.none )


setPlayer : List Player -> Model -> Maybe Player
setPlayer ps m =
    let
        playerName =
            playerNameFromUrl (Url.toString m.curUrl)
    in
    case ps of
        [] ->
            Nothing

        p :: rs ->
            if p.name == playerName then
                Just p

            else
                Debug.log playerName
                setPlayer rs m
