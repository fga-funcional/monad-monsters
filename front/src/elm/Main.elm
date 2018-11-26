module Main exposing (init, main, view)

import Browser
import Browser.Navigation as Nav
import Game exposing (Game, game, mock)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Model exposing (..)
import Pages.Home exposing (homeView)
import Pages.Page exposing (Page(..))
import Routing exposing (..)
import Update exposing (..)
import Url


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model key url Nothing Home "", router url )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    case model.page of
        Home ->
            homeView model


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
