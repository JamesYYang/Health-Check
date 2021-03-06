// Generated by CoffeeScript 1.7.1
(function() {
  var HealthCheckServer;

  HealthCheckServer = (function() {
    function HealthCheckServer(options) {
      this.options = options || {};
      this.options.port = this.options.port || 9020;
      this.options.rulesFile = this.options.rulesFile || "./health-check-rules.json";
    }

    HealthCheckServer.prototype.run = function() {
      var app, self, server;
      app = require("./config/bootstrap")(__dirname, this.options.rulesFile);
      self = this;
      return server = app.listen(this.options.port, function() {
        return console.log("Begin listening on port " + self.options.port);
      });
    };

    return HealthCheckServer;

  })();

  module.exports = function(options) {
    return new HealthCheckServer(options);
  };

}).call(this);

//# sourceMappingURL=index.map
