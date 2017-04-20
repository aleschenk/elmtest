module Hello exposing (..)

import Html exposing (Html, program, div, text, button, input)
import Html.Attributes exposing (placeholder)
import Html.Events exposing (onClick, onInput)


type alias PlayersModel =
    { id : Int
    , name : String
    }


type alias Model =
    { players : PlayersModel
    , content : String
    }


type PlayersMsg
    = List
    | NoList


type Msg
    = ButtonsMsg PlayersMsg
    | Off
    | Change String


type O
    = B (String -> String -> String)


type A
    = C String String String
    | D (String -> Int)


model : Model
model =
    Model (PlayersModel 1 "name") "teset"


init : ( Model, Cmd Msg )
init =
    ( model, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Change newContent ->
            ( { model | content = newContent }, Cmd.none )

        _ ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Text to reverse", onInput Change ] []
        , div [] [ text (String.reverse model.content) ]
        ]


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }
