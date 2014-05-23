request = require('request')

exports.checkHealth = (rule, callback)->
  options = 
    url: rule.Url
    timeout: 10*1000
  request options, (err, response, body)->
  	if err?
  		callback false
  	else if response.statusCode >= 400
  	  callback false
  	else if rule.EnableStringMatching
  	  callback body is rule.MatchString
  	else
  	  callback true
