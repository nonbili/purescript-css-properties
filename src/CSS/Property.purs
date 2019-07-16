module CSS.Property
  ( properties
  , getValues
  ) where

foreign import properties :: Array String

foreign import getValues :: String -> Array String
