module Module.Players exposing (Model, Msg, view)

import Html exposing (Html, program, div, text)


type alias Model =
    { id : Int
    , name : String
    }


type Msg
    = List
    | NoList


view : Model -> Html Msg
view model =
    div [] [ text "Prueba" ]
