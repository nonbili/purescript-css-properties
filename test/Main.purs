module Test.Main where

import Prelude

import CSS.Property (getValues)
import Data.Foldable (sequence_)
import Effect (Effect)
import Jest (expectToEqual, test, describe)

positionValues :: Array String
positionValues =
  [ "static"
  , "relative"
  , "absolute"
  , "sticky"
  , "fixed"
  , "-webkit-sticky"
  ]

colorValues :: Array String
colorValues = ["aliceblue", "antiquewhite", "aqua", "aquamarine"
  , "azure", "beige", "bisque", "black", "blanchedalmond", "blue", "blueviolet"
  , "brown", "burlywood", "cadetblue", "chartreuse", "chocolate", "coral"
  , "cornflowerblue", "cornsilk", "crimson", "currentColor", "cyan", "darkblue", "darkcyan"
  , "darkgoldenrod", "darkgray", "darkgreen", "darkgrey", "darkkhaki", "darkmagenta"
  , "darkolivegreen", "darkorange", "darkorchid", "darkred", "darksalmon", "darkseagreen"
  , "darkslateblue", "darkslategray", "darkslategrey", "darkturquoise", "darkviolet"
  , "deeppink", "deepskyblue", "dimgray", "dimgrey", "dodgerblue", "firebrick"
  , "floralwhite", "forestgreen", "fuchsia", "gainsboro", "ghostwhite", "gold", "goldenrod"
  , "gray", "green", "greenyellow", "grey", "honeydew", "hotpink", "indianred", "indigo"
  , "ivory", "khaki", "lavender", "lavenderblush", "lawngreen", "lemonchiffon", "lightblue"
  , "lightcoral", "lightcyan", "lightgoldenrodyellow", "lightgray", "lightgreen", "lightgrey"
  , "lightpink", "lightsalmon", "lightseagreen", "lightskyblue", "lightslategray"
  , "lightslategrey", "lightsteelblue", "lightyellow", "lime", "limegreen", "linen", "magenta"
  , "maroon", "mediumaquamarine", "mediumblue", "mediumorchid", "mediumpurple", "mediumseagreen"
  , "mediumslateblue", "mediumspringgreen", "mediumturquoise", "mediumvioletred", "midnightblue"
  , "mintcream", "mistyrose", "moccasin", "navajowhite", "navy", "oldlace", "olive", "olivedrab"
  , "orange", "orangered", "orchid", "palegoldenrod", "palegreen", "paleturquoise", "palevioletred"
  , "papayawhip", "peachpuff", "peru", "pink", "plum", "powderblue", "purple", "rebeccapurple"
  , "red", "rosybrown", "royalblue", "saddlebrown", "salmon", "sandybrown", "seagreen", "seashell"
  , "sienna", "silver", "skyblue", "slateblue", "slategray", "slategrey", "snow", "springgreen"
  , "steelblue", "tan", "teal", "thistle", "tomato", "transparent", "turquoise", "violet", "wheat", "white"
  , "whitesmoke", "yellow", "yellowgreen"]

colorProperties :: Array String
colorProperties = [ "backdrop-filter"
  , "background"
  , "background-color"
  , "background-image"
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
  , "border-image"
  , "border-image-source"
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
  , "content"
  , "filter"
  , "mask"
  , "mask-border"
  , "mask-border-source"
  , "mask-image"
  , "outline"
  , "outline-color"
  , "scrollbar-color"
  , "shape-outside"
  , "text-decoration"
  , "text-decoration-color"
  , "text-emphasis"
  , "text-emphasis-color"
  , "text-shadow"
  , "fill"
  , "stroke"
  ]

main :: Effect Unit
main = do
  test "getValues" $ do
    expectToEqual (getValues "position") positionValues
    expectToEqual (getValues "invalid") []
  describe "getValues of color properties" $ do
    sequence_ $ (\p -> test p $ expectToEqual (getValues p) colorValues) <$> colorProperties