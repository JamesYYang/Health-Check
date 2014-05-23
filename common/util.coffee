crypto = require("crypto")

exports.getHash = (data) ->
  crypto.createHash("md5").update(data).digest "hex"