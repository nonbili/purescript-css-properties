var syntax = require("css-tree").lexer;

var properties = Object.keys(syntax.properties);

exports.properties = properties;

const colorTypes = ["bg-layer", "color", "paint", "shadow", "shadow-t"];

function isColorTerm(term) {
  const name = term.name;
  switch (term.type) {
    case "Property":
      return name.includes("color");
    case "Type":
      return colorTypes.includes(name);
    case "Multiplier":
      return isColorTerm(term.term);
    case "Group":
      return term.terms.some(isColorTerm);
    default:
      return false;
  }
}

function acceptsColorKeyword(property) {
  return syntax.properties[property].syntax.terms.some(isColorTerm);
}

let colors = [];

function getColorValues() {
  if (!colors.length) {
    colors = syntax.types["named-color"].syntax.terms
      .filter(_ => _.type === "Keyword")
      .map(_ => _.name);
    colors.push("currentColor");
    colors.sort();
  }
  return colors;
}

exports.getValues = function(property) {
  if (!properties.includes(property)) return [];

  if (acceptsColorKeyword(property)) return getColorValues();

  return syntax.properties[property].syntax.terms
    .filter(function(term) {
      return term.type == "Keyword";
    })
    .map(function(term) {
      return term.name;
    });
};
