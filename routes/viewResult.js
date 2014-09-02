// Generated by CoffeeScript 1.7.1
(function() {
  var getRuleResult, resultStore, show;

  resultStore = require("../common/CheckResultStore").ResultStore;

  module.exports = function(app) {
    app.get("/health-check-result/:ruleId", show);
    return app.param("ruleId", getRuleResult);
  };

  show = function(req, res) {
    return res.json(req.healthResult);
  };

  getRuleResult = function(req, res, next, id) {
    req.healthResult = resultStore.get(id);
    return next();
  };

}).call(this);

//# sourceMappingURL=viewResult.map
