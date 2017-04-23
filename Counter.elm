module Counter exposing (..)

import Html exposing (Html, program, div, a, button, li, ul, text)
import Html.Events exposing (onClick)

-- MODEL 
type alias Model = {
    count: Int
}

init : ( Model, Cmd Msg)
init  = 
    ( Model 0, Cmd.none )

-- UPDATE 
type Msg = Increment | Decrement

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Increment ->
            ({ model | count = model.count + 1 }, Cmd.none)
        
        Decrement ->
            -- ({ model | count = (Basics.max 0 (model.count - 1)) }, Cmd.none)
            ({ model | count = countMax model.count }, Cmd.none)

substract : Int -> Int -> Int
substract num1 num2 = num2 - num1

countMax : Int -> Int
countMax num = num |> substract 1 |> Basics.max 0 

-- VIEW
view : Model -> Html Msg
view model =
    div [] [ 
            text ("Counter " ++ (toString model.count) ++ " "),
            button [ onClick Increment ] [ text "Increment" ],
            button [ onClick Decrement ] [ text "Decrement" ]
        ]

main : Program Never Model Msg
main =
    program
    { init = init
    , view = view
    , update = update
    , subscriptions = (\_ -> Sub.none)
    }
