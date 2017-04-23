module ModelUpdater exposing (..)

import Html exposing (program, div, button, text)
import Html.Events exposing (onClick)


-- MODEL


type alias Players =
    { id : Int
    , name : String
    , totalOfViews : Int
    }


type alias Model =
    { title : String, players : Players }


initialModel : Model
initialModel =
    Model "players" (Players 1 "John" 0)


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- UPDATE


type Msg
    = NewView

type alias Pointer = {
    left : {x : Int, y: Int},
    right : {x : Int, y: Int}
}

model : Pointer
model =
  { left = { x = 1, y = 2 },
    right = { x = 3, y = 4 }
  }

updateLeftX : a -> { d | left : { c | x : b } } -> { d | left : { c | x : a } }
updateLeftX x ({left} as model) =
   { model | left = {left | x = x} }


-- updatePointer : Msg -> Pointer -> ( Pointer, Cmd Msg )
-- updatePointer msg model =
--     case msg of 
--         NewView ->


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewView ->
            let
                players = model.players
                newPlayers = { players | totalOfViews = players.totalOfViews + 1 }
            in
                ({ model | players = newPlayers }, Cmd.none)

            -- (model, Cmd.none)
            -- ( {model | players.totalOfViews = totalOfViews + 1}, Cmd.none )
            -- ( {model | players = { totalOfViews = 1}} ,Cmd.none)



-- SUBSCRIPTION


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html.Html Msg
view model =
    div []
        [ 
            text (toString model.players.totalOfViews),
            button [ onClick NewView ] [ text "new view" ]
        ]


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
