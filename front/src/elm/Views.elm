module Views exposing (cardContainer, playerCards, game)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Card exposing (Card)
import Game exposing (Game)
import Player exposing (Player)
import Msg exposing (..)


game : Game -> Maybe Player -> Html Msg
game g mp =
    let
        content = 
            case mp of
                Nothing -> text "ERROR"
                Just p -> playerCards p.cards
    in

    div [class "game-area"]
    [
        content
    ]

playerCards : List Card -> Html Msg
playerCards cs =
    div [ class "player-cards" ]
        (List.map cardContainer cs)


cardContainer : Card -> Html Msg
cardContainer c =
    div
        [ class "card-container"
        , onClick (SelectCard c)
        ]
        [ div
            [ class "card-content", style "background-color" c.color ]
            [ div [ class "card-name" ] [ text c.name ]
            , div [ class "card-image" ] []
            , div [ class "card-description" ] [ text c.description ]
            ]
        ]
