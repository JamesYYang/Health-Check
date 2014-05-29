// Generated by CoffeeScript 1.6.3
var cors, express, fs, healthCheck, runCheck;

fs = require("fs");

express = require('express');

cors = require('cors');

healthCheck = require("../check/checkEntry").healthCheck;

module.exports = function(appPath, rulesFile) {
  var app, domainError, routes_path;
  domainError = require("../common/domainError");
  app = express();
  app.configure(function() {
    app.use(express.urlencoded({
      limit: '10mb'
    }));
    app.use(express.json({
      limit: '10mb'
    }));
    app.use(express.methodOverride());
    app.use(cors());
    app.use(domainError());
    app.use(app.router);
    return app.use(function(err, req, res, next) {
      res.statusCode = 500;
      res.json({
        Message: err.message,
        Stack: err.stack
      });
      return res.end();
    });
  });
  routes_path = appPath + "/routes";
  fs.readdirSync(routes_path).forEach(function(file) {
    var newPath, stat;
    newPath = routes_path + "/" + file;
    stat = fs.statSync(newPath);
    if (stat.isFile()) {
      if (/(.*)\.(js$)/.test(file)) {
        return require(newPath)(app);
      }
    }
  });
  runCheck(rulesFile);
  return app;
};

runCheck = function(rulesFile) {
  var healthRule;
  healthRule = fs.readFileSync(rulesFile);
  healthCheck.run(JSON.parse(healthRule));
  return fs.watchFile(rulesFile, function(c, p) {
    healthRule = fs.readFileSync(rulesFile);
    return healthCheck.run(JSON.parse(healthRule));
  });
};
