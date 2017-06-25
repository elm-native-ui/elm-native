module NativeApi.PushNotificationIOS exposing (Error(..), register)

{-|
@docs Error, register
-}

import Native.NativeUi.PushNotificationIOS
import Task exposing (Task)


{-| -}
type Error
    = Error String


{-| -}
register : Task Error String
register =
    Native.NativeUi.PushNotificationIOS.register "ignored"