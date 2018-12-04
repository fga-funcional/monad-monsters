module Model exposing (Model)

import Browser
import Browser.Navigation as Nav
import Player exposing (Player)
import Game exposing (Game)
import Html exposing (Html)
import Http
import Pages exposing (Page(..))
import Url


type alias Model =
    { key : Nav.Key
    , curUrl : Url.Url
    , curGame : Maybe Game
    , curPlayer : Maybe Player
    , page : Page
    , search : String
    , playerName : String
    }
