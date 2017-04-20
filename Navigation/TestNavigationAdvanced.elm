module Navigation.TestNavigationAdvanced exposing (mainApp, Model, Msg)

import Html exposing (Html, program, div, a, button, li, ul, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Navigation exposing (Location, newUrl)

-- MODEL 
type alias Model = {
    history : List Location,
    currentRoute : Location,
    count: Int
}

init : Location -> ( Model, Cmd Msg)
init location = 
    ( Model [location] location 0, Cmd.none)

-- UPDATE 
type Msg = UrlChange Location | Increment | Decrement | GoToCustomersPage

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Increment ->
            ({ model | count = model.count + 1 }, Cmd.none)
        
        Decrement ->
            ({ model | count = model.count - 1 }, Cmd.none)

        UrlChange location ->
            ({ model | currentRoute = location, history = location :: model.history }, Cmd.none)

        GoToCustomersPage ->
            (model, newUrl "#/customers")

-- VIEW
type alias RoutePath =
    List String

fromUrlHash : String -> RoutePath
fromUrlHash urlHash =
    urlHash |> String.split "/" |> List.drop 1

link : String -> String -> Html Msg
link name url =
    a [ href url ] [ text name ]

view : Model -> Html Msg
view model =
    div [ style [ ( "margin", "20px" ) ] ]
        [ ul [ ]
            [ li [ ] [ link "counter" "#/counter" ]
            , li [ ] [ link "users" "#/users" ]
            , li [ ] [ link "customers" "#/customers" ]
            ]
        , pageBody model
        ]

pageBody : Model -> Html Msg
pageBody model =
    let
        routePath =
            fromUrlHash model.currentRoute.hash
    in
        case routePath of
            [] ->
                headView

            [ "counter" ] ->
                counterPage model

            [ "users" ] ->
                userPage model

            [ "customers" ] ->
                customerPage model

            _ ->
                div [] [ text "NotFound" ]

headView : Html Msg
headView = 
    ul [] (List.map viewLink ["counter", "user", "customers"])

counterPage : Model -> Html Msg
counterPage model =
    div [] [ 
            text ("Counter " ++ (toString model.count) ++ " "),
            button [ onClick Increment ] [ text "Increment" ],
            button [ onClick Decrement ] [ text "Decrement" ],
            button [ onClick GoToCustomersPage ] [ text "Go to Customer Page" ],
            ul [] (List.map viewLocation model.history)
        ]

userPage : Model -> Html Msg
userPage model =
    text "Welcome to the Users page"

customerPage : Model -> Html Msg
customerPage model =
    text "Welcome to the Customers page"

viewLink : String -> Html msg
viewLink name =
  li [] [ a [ href ("#" ++ name) ] [ text name ] ]

viewLocation : Navigation.Location -> Html msg
viewLocation location =
  li [] [ text (location.pathname ++ location.hash) ]

mainApp : Program Never Model Msg
mainApp =
    Navigation.program UrlChange
    { init = init
    , view = view
    , update = update
    , subscriptions = (\_ -> Sub.none)
    }