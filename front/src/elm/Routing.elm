module Routing exposing (Route(..), delegateRequest, routeParser, viewRoute)

import Html exposing (..)
import Html.Attributes exposing (..)
import List
import Url
import Url.Parser exposing ((</>), Parser, custom, int, oneOf, parse, string, top)

import Api exposing (sendRequest)
import Model exposing (Msg)

type Route
    = Game String
    | Player String String


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ Url.Parser.map Game string
        , Url.Parser.map Player (string </> string)
        ]


viewRoute : Url.Url -> Cmd Msg
viewRoute url =
    let
        maybeRoute =
            parse routeParser url
    in
    case maybeRoute of
        Nothing ->
            Cmd.none

        Just route ->
            delegateRequest route


delegateRequest : Route -> Cmd Msg
delegateRequest route =
    case route of
        Game name ->
            sendRequest

        Player g p ->
            sendRequest


-- delegateView : Route -> Html msg
-- delegateView route =
--     case route of
--         Game name ->
--             div [] [ text ("Game: " ++ name)]

--         Player g p ->
--             div [] [ text ("Player: " ++ p) ]
