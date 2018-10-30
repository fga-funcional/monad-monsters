module Cards exposing (Card, playerCards)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Svg
import Svg.Attributes as SvgAttrs


type alias Card =
    { kind : String, name : String, description : String }


cardContainer : Card -> Html msg
cardContainer c =
    div
        [ class "card-container" ]
        [ Svg.svg
            [ SvgAttrs.width "200px"
            , SvgAttrs.height "40vh"
            ]
            [ Svg.rect
                [ SvgAttrs.width "200px"
                , SvgAttrs.height "40vh"
                , SvgAttrs.stroke "black"
                , SvgAttrs.fill "white"
                ]
                []
            ]
        ]


playerCards : List Card -> Html msg
playerCards xs =
    div
        [ class "player-cards"
        , style "display" "flex"
        , style "flex-wrap" "wrap"
        , style "border" "solid"
        , style "border-color" "red"
        ]
        (List.map cardContainer xs)



-- [ Svg.svg
--     [ SvgAttrs.width "100vw"
--     , SvgAttrs.height "40vh"
--     , style "background" "blue"
--     ]
--     (List.map cardContainer xs)
-- ]
