var syntax = require("css-tree").lexer;

var properties = Object.keys(syntax.properties);

exports.properties = properties;

exports.getValues = function(property) {
  if (!properties.includes(property)) return [];

  return syntax.properties[property].syntax.terms
    .filter(function(term) {
      return term.type == "Keyword";
    })
    .map(function(term) {
      return term.name;
    });
};
