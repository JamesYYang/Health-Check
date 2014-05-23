redis = require("redis")
logger = require("./logger")
config = require("../config/config")
Q = require("q")

client = redis.createClient(6379, config.redisHost)
client.on "error", (err) ->
  logger.error "Redis Error " + err

client.select config.redisDB

exports.getFromRedis = (key) ->
  deferred = Q.defer()
  client.get key, (err, value)->
    if err?
      deferred.reject err
      logger.error "Redis Get Error: " + err + ". key: " + key
    else if value?
      try 
        obj = JSON.parse(value)
        deferred.resolve obj
      catch
        deferred.resolve value
    else
      deferred.resolve null
  deferred.promise

exports.setToRedis = (key, value) ->
  deferred = Q.defer()
  client.set key, value, (err, reply)->
    if err?
      deferred.reject err
      logger.error "Redis Set Error: " + err + ". key: " + key
    else
      deferred.resolve null
  deferred.promise
