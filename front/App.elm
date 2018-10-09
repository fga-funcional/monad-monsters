module App exposing (init, main, update, view)

import Browser
import Cards exposing (Card)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main =
    Browser.sandbox
        { view = view
        , update = update
        , init = init
        }


type alias Model =
    Card


init : Model
init =
    { kind = "Kind", name = "Name", description = "Description" }


type Msg
    = New


update : Msg -> Model -> Model
update msg model =
    case msg of
        New ->
            { kind = "Kind2", name = "Name2", description = "Description2" }


view : Model -> Html Msg
view model =
    div [] [img [ src "/assets/card.svg" ] [text "aaaaa"] ]
