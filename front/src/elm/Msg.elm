module Msg exposing (Msg(..))


import Browser
import Url
import Http
import Game exposing (Game)
import Player exposing (Player)
import Time

type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | LoadCurGame (Result Http.Error Game)
    | LoadGame (Result Http.Error Game)
    | LoadPlayer (Result Http.Error Game)
    | SearchGame String
    | ChangeSearch String
    | ChangePlayer String
    | AuthPlayer Game String
    | UpdateGame Time.Posix
