module View exposing (view)

import Array exposing (Array)
import Cards exposing (Card)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (Model)
import Monsters exposing (Monster)
import Svg
import Svg.Attributes as SvgAttrs
import Update exposing (Msg(..))


view : Model -> Html Msg
view model =
    if model.showMission then
        div [ class "game-area" ]
            [ table
            , mission { kind = "Kind", name = "Missao", description = "Missao 1", color = "grey" }
            , playerCards model.cards
            ]

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


missionContainer : Card -> Html Msg
missionContainer c =
    div
        [ class "mission-container" ]
        [ div
            [ class "mission-content", style "background-color" c.color ]
            [ div [ class "mission-name" ] [ text c.name ]
            , div [ class "mission-image" ] []
            , div [ class "mission-description" ] [ text c.description ]
            ]
        ]


monsterContainer : Html Msg
monsterContainer =
    div
        [ class "monster" ]
        [ div [ class "monster-head" ]
            [ Svg.svg
                [ SvgAttrs.width "40%"
                , SvgAttrs.height "40%"
                , style "background" "#000000"
                ]
                [ Svg.circle
                    [ SvgAttrs.r "50px"
                    , SvgAttrs.fill "#00ff00"
                    , SvgAttrs.cx "50%"
                    , SvgAttrs.cy "50%"
                    ]
                    []
                ]
            ]
        , div [ class "monster-body" ] []
        ]


table : Html Msg
table =
    div
        [ class "game-table" ]
        []


mission : Card -> Html Msg
mission c =
    div
        [ class "mission-monster" ]
        [ div [ class "toggle" ]
            [ button [ onClick ToggleMission ] [ text "Monster" ] ]
        , missionContainer c
        ]


monster : Monster -> Html Msg
monster m =
    div
        [ class "mission-monster" ]
        [ div [ class "toggle" ]
            [ button [ onClick ToggleMission ] [ text "Mission" ] ]
        , monsterContainer
        ]
