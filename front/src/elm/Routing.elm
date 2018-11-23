module Routing exposing (Route(..), delegateRequest, routeParser, router)

import Api
import Html exposing (..)
import Html.Attributes exposing (..)
import List
import Msg exposing (Msg(..))
import Url
import Url.Parser exposing ((</>), Parser, oneOf, parse, string)


type Route
    = Game String
    | Player String String


router : Url.Url -> Cmd Msg
router url =
    let
        maybeRoute =
            parse routeParser url
    in
    case maybeRoute of
        Nothing ->
            Cmd.none

        Just route ->
            delegateRequest route


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ Url.Parser.map Game string
        , Url.Parser.map Player (string </> string)
        ]


delegateRequest : Route -> Cmd Msg
delegateRequest route =
    case route of
        Game name ->
            Api.get (Api.Game name)

        Player g p ->
            Api.get (Api.Player g p)