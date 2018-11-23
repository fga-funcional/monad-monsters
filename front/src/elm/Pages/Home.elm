module Pages.Home exposing (homeView)

import Browser
import Html exposing (Html, button, div, form, h3, input, text)
import Html.Attributes exposing (class, placeholder, value)
import Html.Events exposing (on, onClick, onInput, onSubmit)
import Model exposing (Model, Msg(..))
import Url
import Game exposing (mock)


homeView : Model -> Browser.Document Msg
homeView m =
    { title = "Monad Monsters"
    , body =
        [ div
            [ class "main-container" ]
            [ div
                [ class "input-game" ]
                [ h3 [] [ text "Monad Monsters" ]
                , form
                    []
                    [ input
                        [ onInput ChangeSearch
                        , placeholder "Put your game name e.g.: awesome"
                        , value m.search
                        ]
                        []
                    , button [ onClick SearchGame ] [ text "Go!" ]
                    ]
                ]
            , text <| Url.toString m.curUrl ++ m.search
            , text (Maybe.withDefault mock m.curGame).gameName
            ]
        ]
    }
