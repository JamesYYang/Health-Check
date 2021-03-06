// Generated by CoffeeScript 1.7.1
(function() {
  var CheckEntry, CheckService, checkEntry, util, _;

  CheckService = require("./checkService").CheckService;

  _ = require('lodash');

  util = require("../common/util");

  CheckEntry = (function() {
    function CheckEntry() {
      this.hashValue = "";
      this.checkRules = [];
    }

    return CheckEntry;

  })();

  CheckEntry.prototype.run = function(rules) {
    var newHash;
    if ((rules == null) || rules.length === 0) {
      this.checkRules = [];
      return this.hashValue = "";
    } else {
      console.log("Get Health Rules");
      newHash = util.getHash(JSON.stringify(rules));
      if (newHash !== this.hashValue) {
        this.stop();
        this.checkRules = _.map(rules, function(rule) {
          return new CheckService(rule);
        });
        _.forEach(this.checkRules, function(rule) {
          return rule.beginCheck();
        });
        return this.hashValue = newHash;
      }
    }
  };

  CheckEntry.prototype.stop = function() {
    if (this.checkRules.length > 0) {
      return _.forEach(this.checkRules, function(rule) {
        return rule.stopCheck();
      });
    }
  };

  checkEntry = new CheckEntry();

  exports.healthCheck = checkEntry;

}).call(this);

//# sourceMappingURL=checkEntry.map
