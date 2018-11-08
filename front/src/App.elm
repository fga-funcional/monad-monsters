module App exposing (init, main, update, view)

import Model exposing (Model)
import Update exposing (Msg(..))
import View exposing (playerCards)
import Cards exposing (Card)
import Browser
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


init : Model
init =
    { kind = "Kind", name = "Cor da Iris", description = "Description", color = "red" }


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SelectCard m ->
            ({ kind = "Kind2", name = m.name, description = m.description, color = "blue" }, Cmd.none)


view : Model -> Html Msg
view model =
    div [class "game-area"] [playerCards [ model, model, model, model, model ]]


subscriptions : Model -> Sub Msg
subscriptions model = Sub.none
