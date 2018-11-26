module Pages exposing (Page(..), error, errorWithMsg, game, home, player)

import Browser
import Game exposing (Game, mock)
import Html exposing (..)
import Html.Attributes exposing (class, placeholder, value)
import Html.Events exposing (on, onClick, onInput, onSubmit)
import Msg exposing (Msg(..))
import Url


type Page
    = Home
    | Player
    | Error
    | Game
    | ErrorWithMsg String


home : String -> Browser.Document Msg
home s =
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
                        , value s
                        ]
                        []
                    , button [ onClick (SearchGame s) ] [ text "Go!" ]
                    ]
                ]
            ]
        ]
    }


player : Game -> String -> Browser.Document Msg
player g playerName =
    -- debug purpouses
    { title = g.name ++ " " ++ String.fromInt g.id ++ " | Monad Monsters"
    , body =
        [ div
            [ class "main-container" ]
            [ div
                [ class "input-player" ]
                [ form
                    []
                    [ input
                        [ onInput ChangePlayer
                        , placeholder "Put your nickname e.g.: robert"
                        , value playerName
                        ]
                        []
                    , button [ onClick (AuthPlayer g playerName) ] [ text "Go!" ]
                    ]
                ]
            ]
        ]
    }


game : Game -> Browser.Document Msg
game g =
    let
        content =
            case g.waiting of
                True -> 
                    h2 [] [text "Waiting for players"]
                False ->
                    h2 [] [text "Ready to play"]
    in
    
    { title = g.name ++ " | Monad Monsters"
    , body =
        [ div
            [ class "main-container" ]
            [ div
                [ class "input-player" ]
                [ content ]
            ]
        ]
    }


error : Browser.Document Msg
error =
    { title = "Monad Monsters"
    , body =
        [ div
            [ class "main-container" ]
            [ h1 [] [ text "Sorry, something went wrong! :(" ] ]
        ]
    }


errorWithMsg : String -> Browser.Document Msg
errorWithMsg msg =
    { title = "Monad Monsters"
    , body =
        [ div
            [ class "main-container" ]
            [ h1 [] [ text msg ] ]
        ]
    }
