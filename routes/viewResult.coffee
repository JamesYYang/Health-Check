Q = require("q")
redis = require("../common/redisBiz")

module.exports = (app)->
  app.get "/health-check-result/:ruleId", show
  app.param "ruleId", getRuleResult


show = (req, res)->
	res.json req.healthResult


getRuleResult = (req, res, next, id)->
  key = "HealthCheck:#{id}"
  redis.getFromRedis(key)
  .then (result)->
  	req.healthResult = result
  	next()
  , (error)->
  	next("Fail to get health rule: #{id}")
