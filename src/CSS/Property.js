const csstree = require("css-tree");
const lexer = csstree.lexer;

const properties = Object.keys(lexer.properties);

exports.properties = properties;

const typeKeywords = {};

function getTypeKeywords(type) {
  const ret = [];
  const ast = lexer.types[type].syntax;
  if (!ast) return ret;

  if (typeKeywords[type]) return typeKeywords[type];

  csstree.grammar.walk(ast, {
    enter: node => {
      if (node.type === "Keyword" && !node.name.startsWith("-")) {
        ret.push(node.name);
      } else if (
        node.type === "Type" &&
        node.name !== "deprecated-system-color" &&
        !node.name.includes("()") &&
        !node.name.startsWith("-")
      ) {
        if (typeKeywords[node.name]) {
          ret.push(...typeKeywords[node.name]);
        } else {
          ret.push(...getTypeKeywords(node.name));
        }
      } else if (node.type === "Property") {
        ret.push(...getPropertyKeywords(node.name));
      }
    }
  });
  typeKeywords[type] = Array.from(new Set(ret)).sort();
  return ret;
}

const commonKeywords = ["inherit", "initial", "unset"];

function getPropertyKeywords(property) {
  if (!properties.includes(property)) return [];

  const ret = [...commonKeywords];

  const ast = lexer.properties[property].syntax;
  csstree.grammar.walk(ast, {
    enter: node => {
      if (node.type === "Keyword") {
        if (!node.name.startsWith("-")) {
          ret.push(node.name);
        }
      } else if (node.type === "Type") {
        ret.push(...getTypeKeywords(node.name));
      } else if (node.type === "Property") {
        ret.push(...getPropertyKeywords(node.name));
      }
    }
  });
  return Array.from(new Set(ret)).sort();
}

exports.getPropertyKeywords = getPropertyKeywords;
