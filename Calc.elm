module A exposing (..)

import Html exposing (Html, program, div, text, button, input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (id, type_, value, placeholder, style)


type Msg
    = Add
    | OnInputNumber1 String
    | OnInputNumber2 String
    | OnError String


type alias Model =
    { number1 : String
    , number2 : String
    , total : Int
    , error : Bool
    , errorMessage : String
    }


init : ( Model, Cmd Msg )
init =
    ( { number1 = ""
      , number2 = ""
      , total = 0
      , error = False
      , errorMessage = ""
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Add ->
            ( { model | total = model.total + 1 }, Cmd.none )

        OnError message ->
            ( { model | error = True, errorMessage = message }, Cmd.none )

        _ ->
            ( model, Cmd.none )



-- OnInputNumber1 number ->
--     ( { model | number1 = newNumber1 }, Cmd.none )
-- OnInputNumber2 number ->
--     ( { model | number2 = String.toInt number }, Cmd.none )


view : Model -> Html Msg
view model =
    let
        messageDiv =
            div [ style [ ( "display", "none|block" ) ] ] [ text model.errorMessage ]
    in
        div []
            [ text "Sumar Dos Numeros: "
            , input [ id "number1", type_ "text", placeholder "Numero 1", value model.number1, onInput OnInputNumber1 ] []
            , input [ id "number2", type_ "text", placeholder "Numero 2", value model.number2, onInput OnInputNumber2 ] []
            , button [ onClick Add ] [ text "Sumar" ]
            , div [ style [ ( "display", "none" ) ] ] [ text model.errorMessage ]
            ]


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }
