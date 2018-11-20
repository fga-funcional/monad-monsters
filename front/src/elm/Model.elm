module Model exposing (Model, Msg(..))

import Browser
import Game exposing (Game)
import Http
import Url


type alias Model =
    { curUrl : Url.Url, curGame : Game, error : String }


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | LoadGame (Result Http.Error Game)
    | MakeGetRequest String
