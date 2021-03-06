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


model : Model
model =
    Model (PlayersModel 1 "name") "contenido"



-- view : Model -> Html msg
-- view model =
--     div [] [ text "Prueba"]
-- view : Model -> Html Msg
-- view model =
--     div [] [ text "Prueba", button [ onClick Off ] [ text "Off" ] ]


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Text to reverse", onInput Change ] []
        , div [] [ text (String.reverse model.content) ]
        ]


main : Html Msg
main =
    view model
