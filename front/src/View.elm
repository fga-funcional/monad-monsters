module View exposing (playerCards)

import Cards exposing (Card)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Update exposing (Msg(..))


playerCards : List Card -> Html Msg
playerCards xs =
    div
        [ class "player-cards" ]
        (List.map cardContainer xs)


cardContainer : Card -> Html Msg
cardContainer c =
    div
        [ class "card-container"
        , onClick (SelectCard c)
        ]
        [ div
            [ class "card-content", style "background-color" c.color]
            [ div [ class "card-name" ] [ text c.name ]
            , div [ class "card-image" ] []
            , div [ class "card-description" ] [ text c.description ]
            ]
        ]
