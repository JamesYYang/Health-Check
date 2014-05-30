Health-Check
============

## Install

```
npm install file-monitor
```

## Description

A simple tool for monitor HTTP(s) or TCP service.


## Example

```js
var options, server;

options = {
  port: 8005,
  rulesFile: "./health-check-rules.json"
};

server = require("health-check")(options);

server.run();
```

## Options

The options object has two options:
* `port` : When health-check run, it will build a REST API. You can query health check result via it. So you can specify the port. Default is 9020.
* `rulesFile` : A Json file to describe the health check rule. A sample like below. __You can modify the rules file anytime without stop the program.__

```js
[
	{
		"HealthRuleId": "e970a7f6-0e3e-4bf3-b440-2529f2b0b220",
		"Protocol": "HTTP",
		"EnableStringMatching": false,
		"MatchString": "",
		"Interval": 30,
		"Url": "http://www.google.com"
	}, 
	{
		"HealthRuleId": "dd93cb9a-4401-4d5f-8622-33a800d959cc",
		"Protocol": "TCP",
		"Port": 8080,
		"Host": "127.0.0.1",
		"Interval": 10
	}
]
```

* `HealthRuleId` : You can use GUID or others to indentify the rule. And you can use the id to query check result. Query URL is `http://localhost:9020/health-check-result/:ruleId`.
* `Protocol` : HTTP or HTTPS or TCP.
* `EnableStringMatching` : Only used for HTTP(s). If you disable the string match, the check result is true when http response status below 400. Otherwise, the check result is true when http response status below 400 and response body is matched by MatchString.
* `MatchString` : Only used for HTTP(s). A string used match response body.
* `Interval` : Check interval in seconds. 
* `Url` : Only used for HTTP(s). Check URL.
* `Port` : Only used for TCP.
* `Host` : Only used for TCP.

## License

(The MIT License)

Copyright (c) 2014 James Yang