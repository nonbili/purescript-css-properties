# purescript-css-properties

[![purescript-css-properties on Pursuit](https://pursuit.purescript.org/packages/purescript-css-properties/badge)](https://pursuit.purescript.org/packages/purescript-css-properties)
[![CircleCI](https://circleci.com/gh/nonbili/purescript-css-properties.svg?style=svg)](https://circleci.com/gh/nonbili/purescript-css-properties)

Get a list of CSS properties. Or get a list of CSS values of a property.

## Usage

[csstree](https://github.com/csstree/csstree) is used underneath, install it by

```
# Note the npm package name is css-tree, not csstree!
npm i css-tree
```

In `pulp repl`

```
> import CSS.Property (properties, getValues)
> properties
["--*","-ms-accelerator","-ms-block-progression","-ms-content-zoom-chaining","-ms-content-zooming","-ms-content-zoom-li... ...
> getValues "position"
["static","relative","absolute","sticky","fixed","-webkit-sticky"]
```
