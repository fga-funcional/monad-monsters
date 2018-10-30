module App exposing (init, main, update, view)

import Browser
import Cards exposing (Card, playerCards)
import Style exposing (..)
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
    = NewGame


update : Msg -> Model -> Model
update msg model =
    case msg of
        NewGame ->
            { kind = "Kind2", name = "Name2", description = "Description2" }


view : Model -> Html msg
view model =
    -- div [] [cardsDiv [model, model, model, model, model]]
    playerCards [model, model, model, model, model]


-- view : Model -> Html Msg
-- view model =
--     div []
--         [ div [ style "display" "flex", class "table" ] []
--         , div [ class "player-cards" ] []
--         , div [ class "monster-mission" ] []
--         ]