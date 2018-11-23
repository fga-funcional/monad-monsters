module Model exposing (Model, Msg(..))

import Browser
import Browser.Navigation as Nav
import Game exposing (Game)
import Html exposing (Html)
import Http
import Pages.Page exposing (..)
import Url


type alias Model =
    { key : Nav.Key
    , curUrl : Url.Url
    , curGame : Maybe Game
    , page : Page
    , search : String
    }


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | LoadGame (Result Http.Error Game)
    | MakeGetRequest String
    | SearchGame
    | ChangeSearch String
