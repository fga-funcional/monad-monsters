module Main exposing (init, main, view)

import Browser
import Browser.Navigation as Nav
import Game exposing (Game)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Model exposing (Model)
import Msg exposing (Msg(..))
import Pages
import Routing exposing (..)
import Time
import Update exposing (..)
import Url


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model key url Nothing Nothing Pages.Home "" "", router url )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Time.every 2000 UpdateGame


view : Model -> Browser.Document Msg
view model =
    case model.page of
        Pages.Home ->
            Pages.home model.search

        Pages.Player ->
            case model.curGame of
                Nothing ->
                    -- TODO: FIX
                    Pages.error

                Just game ->
                    Pages.player game model.playerName

        Pages.Game ->
            case model.curGame of
                Nothing ->
                    Pages.error

                Just g ->
                    Pages.game g model.curPlayer

        Pages.Error ->
            Pages.error

        Pages.ErrorWithMsg e ->
            Pages.errorWithMsg e


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }
