module CSS.Property
  ( properties
  , getValues
  ) where

-- | Get a list of CSS properties.
foreign import properties :: Array String

-- | Get value keywords of a property.
-- |
-- | Note there is no validation in this function. Empty array is returned for
-- | invalid property. You can use
-- | [purescript-css-validate](https://pursuit.purescript.org/packages/purescript-css-validate)
-- | for validation.
foreign import getValues :: String -> Array String
