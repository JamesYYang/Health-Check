redis = require("../common/redisBiz")
logger = require("../common/logger")

exports.CheckService = class CheckService
	constructor: (checkRule)->
		@checkRule = checkRule
		@setStrategy()

CheckService::setStrategy = ->
	if @checkRule.Protocol.toLowerCase() is "tcp"
		@checkStrategy = require("./strategies/tcp").checkHealth
	else
	  @checkStrategy = require("./strategies/http").checkHealth

CheckService::beginCheck = ->
	self = this
	@timer = setInterval ->
    self.checkCore()
	, @checkRule.Interval * 1000
	return

CheckService::checkCore = ->
	logger.consoleLog "Begin Health Check for #{@checkRule.HealthRuleId}"
	self = this
	@checkStrategy @checkRule, (result)->
		self.storeResult result

CheckService::storeResult = (result)->
	key = "HealthCheck:#{@checkRule.HealthRuleId}"
	logger.consoleLog "Finish Health Check for #{@checkRule.HealthRuleId}, Result:#{result}"
	redis.setToRedis key, result

CheckService::stopCheck = ->
	logger.consoleLog "Stop Health Check for #{@checkRule.HealthRuleId}"
	clearInterval @timer
