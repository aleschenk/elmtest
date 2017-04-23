module TextMaterial

import Html exposing (Html, div, text, program, span, h1, button, li)
import Html.Attributes exposing (href, class, style)
import Material
import Material.Layout as Layout
import Material.Color as Color
import Material.Button as Button exposing (..)
import Material.Options as Options exposing (css, when)
import Material.Icon as Icon
import Material.Scheme
import Navigation


-- ********************
--       MODEL
-- ********************


type alias MainModel =
    { mdl : Material.Model
    , title : String
    , history : List Navigation.Location
    }


model : Navigation.Location -> MainModel
model location =
    { mdl = Material.model
    , title = "Admin"
    , history = [ location ]
    }



-- ********************
--       INIT
-- ********************


init : Navigation.Location -> ( MainModel, Cmd Msg )
init location =
    ( model location, Material.init Mdl )



-- ********************
--       MESSAGES
-- ********************


type Msg
    = NoOp
    | Mdl (Material.Msg Msg)
    | UrlChange Navigation.Location


type Route
    = UserListRoute
    | NotFoundRoute


viewMain : Html Msg
viewMain =
    text "Hello World"



-- ********************
--        VIEW
-- ********************


mainLayout : MainModel -> Html Msg
mainLayout model =
    Material.Scheme.topWithScheme Color.Teal Color.LightGreen <|
        Layout.render Mdl
            model.mdl
            [ Layout.fixedHeader ]
            { header =
                [ h1 [ style [ ( "padding", "1rem" ) ] ]
                    [ text "Users!" ]
                ]
            , drawer = []
            , tabs = ( [ text "About", text "Team" ], [ Color.background (Color.color Color.Teal Color.S400) ] )
            , main = [ viewMain ]
            }


view : MainModel -> Html Msg
view model =
    mainLayout model



-- ********************
--        UPDATE
-- ********************


update : Msg -> MainModel -> ( MainModel, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Mdl msg_ ->
            Material.update Mdl msg_ model

        UrlChange location ->
            ( { model | history = location :: model.history }
            , Cmd.none
            )



-- ********************
--    SUBSCRIPTION
-- ********************


subscriptions : MainModel -> Sub Msg
subscriptions model =
    Sub.batch [ Sub.none ]



-- ********************
--        MAIN
-- ********************


main : Program Never MainModel Msg
main =
    Navigation.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
