module Routing exposing (Route(..), delegateView, routeParser, viewRoute)

import Html exposing (..)
import Html.Attributes exposing (..)
import Url
import Url.Parser exposing ((</>), Parser, oneOf, parse, string)


type Route
    = Game String


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ Url.Parser.map Game string
        ]


viewRoute : Url.Url -> Html msg
viewRoute url =
    let
        maybeRoute =
            parse routeParser url
    in
    case maybeRoute of
        Nothing ->
            div[][text "Invalid Url"]
        Just route ->  
            delegateView route


delegateView : Route -> Html msg
delegateView route =
    case route of
        Game name ->
            div [] [ text name ]
