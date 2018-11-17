module Routing exposing (Route(..), delegateView, routeParser, viewRoute)

import Html exposing (..)
import Html.Attributes exposing (..)
import List
import Url
import Url.Parser exposing ((</>), Parser, custom, int, oneOf, parse, string, top)


type Route
    = Game String
    | Player String String


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ Url.Parser.map Game string
        , Url.Parser.map Player (string </> string)
        ]


viewRoute : Url.Url -> Html msg
viewRoute url =
    let
        maybeRoute =
            parse routeParser url
    in
    case maybeRoute of
        Nothing ->
            div [] [ text "Invalid Url" ]

        Just route ->
            delegateView route


delegateView : Route -> Html msg
delegateView route =
    case route of
        Game name ->
            div [] [ text ("Game: " ++ name) ]

        Player g p ->
            div [] [ text ("Player: " ++ p) ]
