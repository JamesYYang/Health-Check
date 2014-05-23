redis = require("../common/redisBiz")
CheckService = require("./checkService").CheckService
_ = require('lodash')
util = require("../common/util")
config = require("../config/config")
Q = require("q")
logger = require("../common/logger")

class CheckEntry
	constructor: ->
		@hashValue = ""
		@checkRules = []

CheckEntry::run = ->
	key = "HealthCheckAllRules"
	self = this
	redis.getFromRedis(key)
	.then (rules)->
		debugger
		if not rules? or rules.length is 0
			self.checkRules = []
			@hashValue = ""
		else
      logger.consoleLog "Get Health Info"
		  newHash = util.getHash JSON.stringify(rules)
		  if newHash isnt self.hashValue
        self.stop()
        self.checkRules = _.map rules, (rule)->
          return new CheckService(rule)
        _.forEach self.checkRules, (rule)->
          rule.beginCheck()
        self.hashValue = newHash

CheckEntry::stop = ->
	if @checkRules.length > 0
		_.forEach @checkRules, (rule)->
			rule.stopCheck()

checkEntry = new CheckEntry()

exports.runCheck = ->
	checkEntry.run()
	setInterval ->
		checkEntry.run()
	, config.checkInterval