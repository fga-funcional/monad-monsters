module Routing exposing (Route(..), baseUrl, delegateRequest, makeUrl, routeParser, router)

import Api
import Html exposing (..)
import Html.Attributes exposing (..)
import List
import Msg exposing (Msg(..))
import Url
import Url.Parser exposing ((</>), Parser, oneOf, parse, string)


type Route
    = CreateGame String
    | EnterGame String String


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
        [ Url.Parser.map CreateGame string
        , Url.Parser.map EnterGame (string </> string)
        ]


delegateRequest : Route -> Cmd Msg
delegateRequest route =
    case route of
        CreateGame name ->
            Api.get (Api.CreateGame name)

        EnterGame g p ->
            Api.get (Api.EnterGame g p)


makeUrl : List String -> String
makeUrl lst =
    baseUrl ++ String.join "/" lst


baseUrl : String
baseUrl =
    "http://localhost:3000/"
