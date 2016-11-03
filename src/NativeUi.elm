module NativeUi exposing (NativeEventHandler, Node, customNode, node, string, style, mergeStyles, on, onReact, Property, property, map, program, renderProperty, renderListProperty)

{-| Render your application as a React Native app.

# Common Helpers
@docs node, string, customNode, style, mergeStyles, property, map, renderProperty, renderListProperty

# Events
@docs on, onReact

# Types
@docs Node, Property

# Program
@docs program
-}

import Json.Decode as Decode exposing (Value, Decoder)
import Native.NativeUi
import NativeUi.Style as Style


type alias NativeEventHandler =
    Decode.Value


{-| -}
type Node msg
    = Node


{-| -}
type Property msg
    = Property


{-| -}
node : String -> List (Property msg) -> List (Node msg) -> Node msg
node =
    Native.NativeUi.node


{-| -}
customNode : String -> String -> Maybe String -> List (Property msg) -> List (Node msg) -> Node msg
customNode =
    Native.NativeUi.customNode


{-| -}
string : String -> Node msg
string =
    Native.NativeUi.string


{-| -}
property : String -> Value -> Property msg
property =
    Native.NativeUi.property


{-| -}
renderProperty : String -> Decoder a -> (a -> Node b) -> Property msg
renderProperty =
    Native.NativeUi.renderProperty


{-| -}
renderListProperty : String -> Decoder a -> (a -> List (Node b)) -> Property msg
renderListProperty =
    Native.NativeUi.renderListProperty


{-| -}
style : List Style.Style -> Property msg
style styles =
    Style.encode styles
        |> Native.NativeUi.style


{-| -}
mergeStyles : List Style.NativeStyle -> Property msg
mergeStyles styles =
    Style.merge styles
        |> Native.NativeUi.style


{-| -}
on : String -> Decoder msg -> Property msg
on eventName =
    let
        realEventName =
            "on" ++ eventName
    in
        Native.NativeUi.on realEventName


{-| -}
onReact : String -> NativeEventHandler -> Property msg
onReact eventName =
    let
        realEventName =
            "on" ++ eventName
    in
        Native.NativeUi.onReact realEventName


{-| -}
map : (a -> b) -> Node a -> Node b
map tagger element =
    Native.NativeUi.map tagger element


{-| -}
program :
    { view : model -> Node msg
    , update : msg -> model -> ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , init : ( model, Cmd msg )
    }
    -> Program Never model msg
program stuff =
    Native.NativeUi.program stuff
