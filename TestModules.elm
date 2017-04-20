module TestModules exposing (..)

import Html exposing (Html, program, div, text)
import Module.Players as Players
import Array exposing (Array)


type alias Model =
    { players : Players.Model
    , selectedTab : Int
    }


type alias Title =
    String


type alias Url =
    String


type Msg
    = PlayersMsg Players.Msg
    | Off


tabs : List ( Title, Url, Model -> Html Msg )
tabs =
    [ ( "Players", "players", .players >> Players.view >> Html.map PlayersMsg )
    ]


tabTitles : List (Html a)
tabTitles =
    List.map (\( x, _, _ ) -> text x) tabs


tabViews : Array (Model -> Html Msg)
tabViews =
    List.map (\( _, _, v ) -> v) tabs |> Array.fromList


tabUrls : Array Url
tabUrls =
    List.map (\( _, x, _ ) -> x) tabs |> Array.fromList


urlOf : Model -> String
urlOf model =
    "#" ++ (Array.get model.selectedTab tabUrls |> Maybe.withDefault "")


view : Model -> Html Msg
view model =
    div [] tabTitles



-- div [] [ text "Prueba" ]


model : Model
model =
    { players = { id = 1, name = "Pepe" }, selectedTab = 0 }


main : Html Msg
main =
    view model
