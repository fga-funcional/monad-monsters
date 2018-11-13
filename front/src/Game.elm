module Game exposing (..)

import Array exposing (Array)
import Cards exposing (Card)
import Monsters exposing (Monster)


type alias Game =
    { cards : Array Card
    , mission : String
    , monster : Monster
    , showMission : Bool
    }
