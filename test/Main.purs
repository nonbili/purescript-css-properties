module Test.Main where

import Prelude

import CSS.Property (getValues)
import Effect (Effect)
import Jest (expectToEqual, test)

positionValues :: Array String
positionValues =
  [ "static"
  , "relative"
  , "absolute"
  , "sticky"
  , "fixed"
  , "-webkit-sticky"
  ]

main :: Effect Unit
main = do
  test "getValues" $ do
    expectToEqual (getValues "position") positionValues
    expectToEqual (getValues "invalid") []
