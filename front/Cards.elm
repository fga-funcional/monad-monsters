module Cards exposing (Card, cardContainer, playerCards)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Svg
import Svg.Attributes as SvgAttrs


type alias Card =
    { kind : String, name : String, description : String }


playerCards : List Card -> Html msg
playerCards xs =
    div
        [ class "player-cards" ]
        (List.map cardContainer xs)


cardContainer : Card -> Html msg
cardContainer c =
    div
        [ class "card-container" ]
        [ text c.name, text c.description ]