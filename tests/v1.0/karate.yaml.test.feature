
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
		"commands": [
		{
			"command": "node -v",
			"silent": true,
			"print": false,
			"node": "16"
		}
		]
	}
	"""
	When method POST
	Then status 200
	And match $ ==
	"""
	{
	"node": [
	{
		"result": "#notnull",
		"success": true
	}
	]
	}
	"""
	