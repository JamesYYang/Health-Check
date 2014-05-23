domain = require("domain")
logger = require("./logger")
module.exports = ->
  (req, res, next) ->
    d = domain.create()
    d.add req
    d.add res
    d.on "error", (err)->
      d._throwErrorCount = (d._throwErrorCount || 0) + 1
      if (d._throwErrorCount > 1)
        logger.error "[domain-error] #{req.method} #{req.url} throw error #{d._throwErrorCount} times"
        logger.error err
        return

      res.setHeader("Connection", "close")
      next err

    d.run next