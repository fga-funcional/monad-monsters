module App exposing (init, main)

import Browser
import Cards exposing (Card)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Encode exposing (Value)
import Model exposing (Model)
import Update exposing (Msg(..), update)
import View exposing (view)
import Cards exposing (mock)


main : Program Value Model Msg
main =
    Browser.element
        { init = \value -> ( init, Cmd.none )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


init : Model
init =
    { cards = mock, mission = "Missao", monster = {head = "Cabeca"}, showMission = True}


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
