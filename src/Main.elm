module Main exposing (..)

import Browser
import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (placeholder, style, type_, value)
import Html.Events exposing (onClick, onInput)
import String exposing (isEmpty, length)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { counter : Int
    , content : String
    , form :
        { name : String
        , password : String
        , passwordAgain : String
        }
    }


init : Model
init =
    { counter = 0
    , content = "Nada"
    , form =
        { name = "john"
        , password = "john1"
        , passwordAgain = "john2"
        }
    }



-- UPDATE


type Msg
    = Increment
    | Decrement
    | IncrementBy10
    | Reset
    | Change String
    | Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | counter = model.counter + 1 }

        Decrement ->
            { model | counter = model.counter - 1 }

        Reset ->
            { model | counter = 0 }

        IncrementBy10 ->
            { model | counter = model.counter + 10 }

        Change string ->
            { model | content = string }

        Name name ->
            { model | form = { name = name, password = model.form.password, passwordAgain = model.form.passwordAgain } }

        Password string ->
            model

        PasswordAgain string ->
            model



-- VIEW


view : Model -> Html Msg
view model =
    let
        buttonsExample : Html Msg
        buttonsExample =
            div []
                [ button [ onClick Decrement ] [ text "-" ]
                , div [] [ text (String.fromInt model.counter) ]
                , button [ onClick Increment ] [ text "+" ]
                , button [ onClick Reset ] [ text "Reset" ]
                , button [ onClick IncrementBy10 ] [ text "Add 10" ]
                , input [ placeholder "Text to reverse", value model.content, onInput Change ] []
                , div [] [ text (String.reverse model.content) ]
                , viewInput "text" "Name" model.form.name Name
                , viewInput "text" "Password" model.form.password Password
                , viewInput "text" "Password again" model.form.passwordAgain PasswordAgain
                , viewValidation model
                ]

        inputExample =
            div []
                [ text "This is another component" ]
    in
    div []
        [ buttonsExample
        , inputExample
        ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v m =
    input [ type_ t, placeholder p, value v, onInput m ] []


viewValidation : Model -> Html msg
viewValidation model =
    if length model.form.name /= 0 then
        div [ style "color" "green" ] [ text "OK" ]

    else
        div [ style "color" "red" ] [ text "Name must be filled." ]



-- Questions:
-- is the Model ever-growing? Yes, but as it grows new functional components will be concerned about just parts of it
