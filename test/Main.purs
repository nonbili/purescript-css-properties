module Test.Main where

import Prelude

import CSS.Property (getPropertyKeywords)
import Data.Array as Array
import Data.Foldable (sequence_)
import Effect (Effect)
import Jest (describe, expectToEqual, test)

colorValues :: Array String
colorValues =
  ["aliceblue", "antiquewhite", "aqua", "aquamarine", "azure", "beige", "bisque", "black", "blanchedalmond", "blue", "blueviolet", "brown", "burlywood", "cadetblue", "chartreuse", "chocolate", "coral", "cornflowerblue", "cornsilk", "crimson", "currentcolor", "cyan", "darkblue", "darkcyan", "darkgoldenrod", "darkgray", "darkgreen", "darkgrey", "darkkhaki", "darkmagenta", "darkolivegreen", "darkorange", "darkorchid", "darkred", "darksalmon", "darkseagreen", "darkslateblue", "darkslategray", "darkslategrey", "darkturquoise", "darkviolet", "deeppink", "deepskyblue", "dimgray", "dimgrey", "dodgerblue", "firebrick", "floralwhite", "forestgreen", "fuchsia", "gainsboro", "ghostwhite", "gold", "goldenrod", "gray", "green", "greenyellow", "grey", "honeydew", "hotpink", "indianred", "indigo", "inherit", "initial", "ivory", "khaki", "lavender", "lavenderblush", "lawngreen", "lemonchiffon", "lightblue", "lightcoral", "lightcyan", "lightgoldenrodyellow", "lightgray", "lightgreen", "lightgrey", "lightpink", "lightsalmon", "lightseagreen", "lightskyblue", "lightslategray", "lightslategrey", "lightsteelblue", "lightyellow", "lime", "limegreen", "linen", "magenta", "maroon", "mediumaquamarine", "mediumblue", "mediumorchid", "mediumpurple", "mediumseagreen", "mediumslateblue", "mediumspringgreen", "mediumturquoise", "mediumvioletred", "midnightblue", "mintcream", "mistyrose", "moccasin", "navajowhite", "navy", "oldlace", "olive", "olivedrab", "orange", "orangered", "orchid", "palegoldenrod", "palegreen", "paleturquoise", "palevioletred", "papayawhip", "peachpuff", "peru", "pink", "plum", "powderblue", "purple", "rebeccapurple", "red", "rosybrown", "royalblue", "saddlebrown", "salmon", "sandybrown", "seagreen", "seashell", "sienna", "silver", "skyblue", "slateblue", "slategray", "slategrey", "snow", "springgreen", "steelblue", "tan", "teal", "thistle", "tomato", "transparent", "turquoise", "unset", "violet", "wheat", "white", "whitesmoke", "yellow", "yellowgreen"]

colorProperties :: Array String
colorProperties =
  [ "background-color"
  , "border"
  , "border-block"
  , "border-block-color"
  , "border-block-end"
  , "border-block-end-color"
  , "border-block-start"
  , "border-block-start-color"
  , "border-bottom"
  , "border-bottom-color"
  , "border-color"
  , "border-inline"
  , "border-inline-end"
  , "border-inline-color"
  , "border-inline-end-color"
  , "border-inline-start"
  , "border-inline-start-color"
  , "border-left"
  , "border-left-color"
  , "border-right"
  , "border-right-color"
  , "border-top"
  , "border-top-color"
  , "box-shadow"
  , "caret-color"
  , "color"
  , "column-rule"
  , "column-rule-color"
  , "outline"
  , "outline-color"
  , "scrollbar-color"
  , "text-decoration-color"
  , "text-emphasis"
  , "text-emphasis-color"
  , "text-shadow"
  , "fill"
  , "stroke"
  ]

main :: Effect Unit
main = do
  test "invalid" $ do
    expectToEqual (getPropertyKeywords "invalid") []

  test "align-items" $ do
    expectToEqual (getPropertyKeywords "align-items")
      ["baseline", "center", "end", "first", "flex-end", "flex-start", "inherit", "initial", "last", "normal", "safe", "self-end", "self-start", "start", "stretch", "unsafe", "unset"]

  test "background" $ do
    expectToEqual (getPropertyKeywords "background") $ Array.sort $ colorValues <>
      [ "auto"
      , "border-box"
      , "bottom"
      , "center"
      , "contain"
      , "content-box"
      , "cover"
      , "fixed"
      , "left"
      , "local"
      , "no-repeat"
      , "none"
      , "padding-box"
      , "repeat"
      , "repeat-x"
      , "repeat-y"
      , "right"
      , "round"
      , "scroll"
      , "space"
      , "top"
      ]

  test "height" $ do
    expectToEqual (getPropertyKeywords "height")
      ["auto", "available", "border-box", "content-box", "fit-content", "inherit", "initial", "max-content", "min-content", "unset"]

  test "position" $ do
    expectToEqual (getPropertyKeywords "position")
      ["absolute", "fixed", "inherit", "initial", "relative", "static", "sticky", "unset"]

  test "text-decoration" $ do
    expectToEqual (getPropertyKeywords "text-decoration") $ Array.sort $ colorValues <>
      [ "blink"
      , "dashed"
      , "dotted"
      , "double"
      , "line-through"
      , "none"
      , "overline"
      , "solid"
      , "underline"
      , "wavy"
      ]

  describe "getPropertyKeywords of color properties" $ do
    sequence_ $ colorProperties <#> \p ->
      test p $ expectToEqual
        (Array.intersect colorValues (getPropertyKeywords p))
        colorValues
