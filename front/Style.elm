module Style exposing (cardContainer, cardsDiv)

import Cards exposing (Card)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


cardsDiv : List Card -> Html msg
cardsDiv xs =
    div
        [ style "border-style" "solid"
        , style "border-color" "red"
        , style "display" "flex"
        , style "height" "35vh"
        , style "position" "absolute"
        , style "bottom" "0"
        , style "width" "97vw"
        , style "justify-content" "center"
        , style "align-items" "center"
        ]
        (List.map cardContainer xs)


cardContainer : Card -> Html msg
cardContainer c =
    div
        [ style "border-style" "solid"
        , style "border-color" "black"
        , style "height" "75%"
        , style "margin" "5%"
        ]
        [ text c.name, text c.description ]
