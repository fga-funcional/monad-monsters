module App exposing (init, main, update, view)

import Browser
import Cards exposing (Card, playerCards)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Encode exposing (Value)


main : Program Value Model Msg
main =
    Browser.element
        { init = \value -> (init, Cmd.none)
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias Model =
    Card


init : Model
init =
    { kind = "Kind", name = "Name", description = "Description" }


type Msg
    = NewGame


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NewGame ->
            ({ kind = "Kind2", name = "Name2", description = "Description2" }, Cmd.none)


view : Model -> Html msg
view model =
    div [] [playerCards [ model, model, model, model, model ]]


subscriptions : Model -> Sub Msg
subscriptions model = Sub.none
