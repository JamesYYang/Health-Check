fs = require("fs")
express = require('express')
cors = require('cors')
config = require("../config/config")

module.exports = (appPath)->
  
  domainError = require("../common/domainError")
  app = express()
  app.configure ->
    app.use express.urlencoded({limit: '10mb'})
    app.use express.json({limit: '10mb'})
    app.use express.methodOverride()
    app.use cors()
    app.use domainError()
    app.use app.router
    app.use (err, req, res, next)->
      res.statusCode = 500
      res.json
        Message: err.message
        Stack: err.stack if config.debug is true
      res.end()

  #注册express route
  routes_path = appPath + "/routes"
  fs.readdirSync(routes_path).forEach (file) ->
    newPath = routes_path + "/" + file
    stat = fs.statSync(newPath)
    if stat.isFile()
      if (/(.*)\.(js$)/.test(file))
        require(newPath)(app)

  app