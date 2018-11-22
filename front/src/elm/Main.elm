module Main exposing (init, main, view)

import Browser
import Browser.Navigation as Nav
import Game exposing (Game, game, mock)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Model exposing (..)
import Routing exposing (..)
import Update exposing (..)
import Url


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model url mock "", router url )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    { title = "Monad Monsters"
    , body =
        [ div []
            [ button [ onClick (MakeGetRequest "http://localhost:8000/newgame") ] [ text "tst" ]
            , text model.curGame.gameName
            , text model.error
            ]
        ]
    }


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
