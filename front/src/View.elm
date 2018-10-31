module View exposing (playerCards)

import Update exposing (Msg(..))
import Cards exposing (Card)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


playerCards : List Card -> Html Msg
playerCards xs =
    div
        [ class "player-cards" ]
        (List.map cardContainer xs)


cardContainer : Card -> Html Msg
cardContainer c =
    div
        [ class "card-container"
        , onClick SelectCard
        ]
        [ text c.name, text c.description ]
