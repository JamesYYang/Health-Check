// Generated by CoffeeScript 1.6.3
var crypto;

crypto = require("crypto");

exports.getHash = function(data) {
  return crypto.createHash("md5").update(data).digest("hex");
};