module Msg exposing (Msg(..))


import Browser
import Url
import Http
import Game exposing (Game)
import Player exposing (Player)

type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | LoadGame (Result Http.Error Game)
    | LoadPlayer (Result Http.Error Player)
    | MakeGetRequest String
    | SearchGame String
    | ChangeSearch String
    | ChangePlayer String
    | AuthPlayer Game String
