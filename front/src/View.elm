module View exposing (view)

import Cards exposing (Card)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (Model)
import Update exposing (Msg(..))
import Array exposing (Array)


view : Model -> Html Msg
view model =
    div [ class "game-area" ]
        [ table, mission, playerCards model.cards ]


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


mission : Html Msg
mission =
    div
        [ class "mission-monster" ]
        [ div [ class "toggle" ]
            [ button [ onClick ShowMonster ] [ text "Monster" ] ]
        ]
