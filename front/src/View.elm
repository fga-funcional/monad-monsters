module View exposing (view)

import Array exposing (Array)
import Cards exposing (Card)
import Monsters exposing (Monster)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (Model)
import Update exposing (Msg(..))


view : Model -> Html Msg
view model =
    if model.showMission then
        div [ class "game-area" ]
            [ table, mission "Mission", playerCards model.cards ]
    else
        div [ class "game-area" ]
            [ table, monster model.monster, playerCards model.cards ]


playerCards : Array Card -> Html Msg
playerCards xs =
    div
        [ class "player-cards" ]
        (Array.toList <| Array.indexedMap cardContainer xs)


cardContainer : Int -> Card -> Html Msg
cardContainer i c =
    div
        [ class "card-container"
        , onClick (SelectCard i c)
        ]
        [ div
            [ class "card-content", style "background-color" c.color ]
            [ div [ class "card-name" ] [ text c.name ]
            , div [ class "card-image" ] []
            , div [ class "card-description" ] [ text c.description ]
            ]
        ]


table : Html Msg
table =
    div
        [ class "game-table" ]
        []



mission : String -> Html Msg
mission m =
    div
        [ class "mission-monster" ]
        [ div [ class "toggle" ]
            [ button [onClick ToggleMission ] [ text "Monster" ] ]
        ]


monster : Monster -> Html Msg
monster m =
    div
        [ class "mission-monster" ]
        [ div [ class "toggle" ]
            [ button [onClick ToggleMission ] [ text "Mission" ] ]
        ]
