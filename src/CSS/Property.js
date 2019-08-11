var syntax = require("css-tree").lexer;
var grammar = require("css-tree").grammar;

var properties = Object.keys(syntax.properties);

exports.properties = properties;

// build map { t0: [t1,...tN] } where t1..tN are directly referenced by t0
function getAllTypeReferences() {
  function typeReferences(term) {
    const result = [];
    grammar.walk(term, {
      enter: node => {
        if (node.type === "Type") {
          result.push(node.name);
        }
      }
    });
    return result;
  }

  const result = {};
  for (t in syntax.types) {
    const type = syntax.types[t];
    if (type && type.syntax !== null) {
      result[type.name] = typeReferences(type.syntax);
    }
  }
  return result;
}

var _colorTypes = undefined;

function getColorTypes() {
  if (_colorTypes !== undefined) {
    return _colorTypes;
  } else {
    const typeReferences = getAllTypeReferences();
    const resolved = { color: true };

    function isColor(typeName, visited) {
      if (resolved[typeName] !== undefined) {
        return resolved[typeName];
      } else {
        if (visited[typeName]) {
          return false;
        } else {
          visited[typeName] = true;
          if (typeReferences[typeName] !== undefined) {
            const res = exists(typeReferences[typeName], y =>
              isColor(y, visited)
            );
            resolved[typeName] = res;
            return res;
          } else {
            resolved[typeName] = false;
          }
        }
      }
    }

    _colorTypes = [
      ...["color"],
      ...Object.keys(typeReferences).filter(x => isColor(x, {}))
    ];
    return _colorTypes;
  }
}

exports.getColorTypes = getColorTypes;

var _colorProperties = undefined;

function getColorProperties() {
  if (_colorProperties !== undefined) {
    return _colorProperties;
  }

  const colorTypes = getColorTypes();

  const resolvedProperties = {};
  const traversed = {};

  function propertyIsColor(term) {
    switch (term.type) {
      case "Property":
        if (resolvedProperties[term.name] !== undefined) {
          return resolvedProperties[term.name];
        } else {
          if (traversed[term.name] !== undefined) {
            return false;
          } else {
            traversed[term.name] = true;
            const isColor = propertyIsColor(
              syntax.properties[term.name].syntax
            );
            resolvedProperties[term.name] = isColor;
            return isColor;
          }
        }
      case "Type":
        return colorTypes.includes(term.name);
      case "Multiplier":
        return propertyIsColor(term.term);
      case "Group":
        return exists(term.terms, propertyIsColor);
    }
  }

  _colorProperties = Object.keys(syntax.properties).filter(p =>
    propertyIsColor(syntax.properties[p].syntax)
  );
  return _colorProperties;
}

exports.colorProperties = getColorProperties;

function getColorValues() {
  const colors = syntax.types["named-color"].syntax.terms
    .map(x => x.name)
    .filter(x => x !== "-non-standard-color");
  colors.push("currentColor");
  return colors.sort();
}

exports.getValues = function(property) {
  if (!properties.includes(property)) return [];

  if (getColorProperties().includes(property)) return getColorValues();

  return syntax.properties[property].syntax.terms
    .filter(function(term) {
      return term.type == "Keyword";
    })
    .map(function(term) {
      return term.name;
    });
};

// ------------------------- helper functions -----------------

function exists(xs, predicate) {
  for (var i = 0; i < xs.length; i++) {
    if (predicate(xs[i])) {
      return true;
    }
  }
  return false;
}
