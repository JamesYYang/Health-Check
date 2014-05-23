net = require("net")

exports.checkHealth = (rule, callback)->
  socket = new net.Socket()
  returned = false

  socket.setTimeout 10 * 1000, ->
    returned = true
    socket.end()
    callback false

  socket.connect rule.Port, rule.Address, ->
    if not returned
      returned = true
      callback true
    socket.end()

  socket.on "error", ->
    returned = true
    socket.destroy()
    callback false


