logger = require("./common/logger")
config = require("./config/config")
log4js = require("log4js")
path = require("path")
healthCheck = require("./check/checkEntry")
port = config.listenPort || 9020
log4js.configure path.join(__dirname, "log4js_configuration.json"),
  reloadSecs: 50
  cwd: __dirname
process.on "uncaughtException", (err) ->
  logger.error "[uncaught-error] exception: " + err + "\r\nstack: " + err.stack

app = require("./config/bootstrap")(__dirname)

server = app.listen port, ->
  logger.log("Begin listening on port #{port}")

healthCheck.runCheck()
