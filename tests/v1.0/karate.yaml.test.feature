
Feature: Basic

# The secrects can be used in the payload with the following syntax #(mysecretname)
Background:


Scenario: get request

	Given url karate.properties['testURL']

	And path '/'
	And header Direktiv-ActionID = 'development'
	And header Direktiv-TempDir = '/tmp'
	And request
	"""
	{
		"files": [
			{
				"name": "out.js",
				"data": "const { v4: uuidv4 } = require('uuid');\n console.log(uuidv4());"
			}
		],
		"context": "helloworld",
		"node": "16",
		"commands": [
		{
			"command": "npm install uuid",
		},
		{
			"command": "node out.js"
		}
		]
	}
	"""
	When method POST
	Then status 200
	# And match $ ==
	# """
	# {
	# "node": [
	# {
	# 	"result": "#notnull",
	# 	"success": true
	# }
	# ]
	# }
	# """
	