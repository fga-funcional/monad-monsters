module Update exposing (Msg(..), update)

import Array exposing (Array)
import Cards exposing (Card)
import Model exposing (Model)


type Msg
    = SelectCard Int Card
    | ToggleMission


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectCard index card ->
            if String.contains "!" card.name then
                ( { model | cards = Array.set index { card | name = String.dropRight 1 card.name } model.cards }
                , Cmd.none
                )
            else
                ( { model | cards = Array.set index { card | name = card.name ++ "!" } model.cards }
                , Cmd.none
                )

        ToggleMission ->
            if model.showMission then
                ( { model | showMission = False }, Cmd.none )
            else
                ( { model | showMission = True }, Cmd.none )
