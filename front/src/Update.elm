module Update exposing (Msg(..), update)

import Cards exposing (Card)
import Model exposing (Model)
import Array exposing (Array)


type Msg
    = SelectCard Int Card
    | ShowMonster


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectCard index card ->
            ( { model | cards = Array.set index {card | name = card.name ++ "!"} model.cards }
            , Cmd.none
            )

        ShowMonster ->
            (model, Cmd.none)
