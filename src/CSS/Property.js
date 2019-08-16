const csstree = require("css-tree");
const lexer = csstree.lexer;

const properties = Object.keys(lexer.properties);

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
  return lexer.properties[property].syntax.terms.some(isColorTerm);
}

let namedColors = [];

function getColorValues() {
  if (!namedColors.length) {
    namedColors = lexer.types["named-color"].syntax.terms
      .filter(_ => _.type === "Keyword")
      .map(_ => _.name);
    namedColors.push("currentColor", ...commonValues);
    namedColors.sort();
  }
  return namedColors;
}

function getKeywordsByType(type) {
  const ret = [];
  const ast = lexer.types[type].syntax;
  if (!ast) return ret;

  csstree.grammar.walk(ast, {
    enter: node => {
      if (node.type === "Keyword") {
        ret.push(node.name);
      }
    }
  });
  return ret;
}

const commonValues = ["inherit", "initial", "revert", "unset"];

exports.getValues = function(property) {
  if (!properties.includes(property)) return [];

  if (acceptsColorKeyword(property)) return getColorValues();

  const ret = [...commonValues];
  const ast = lexer.properties[property].syntax;
  csstree.grammar.walk(ast, {
    enter: node => {
      if (node.type === "Keyword") {
        if (!node.name.startsWith("-")) {
          ret.push(node.name);
        }
      } else if (node.type === "Type") {
        ret.push(...getKeywordsByType(node.name));
      }
    }
  });
  return ret.sort();
};
