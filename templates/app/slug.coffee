#--------- Hem setup options

developmentHem =
	baseAppRoute: "/appname"
	proxy:
		"/appname":
			"host": "localhost"
			"port": 8080
			"path": "/segway"

stagingHem =
	baseAppRoute: "/appname"
	proxy:
		"/appname":
			"host": "test.yoursite.com"
			"path": "/appname"

productionHem =
	baseAppRoute: "/appname"
	proxy:
		"/appname2":
			"host": "www.yoursite.com"
			"path": "/appname"

# setup hem to work with different segway runtimes
if "--staging" in process.argv
	hemSetup = stagingHem
else if "--production" in process.argv
	hemSetup = productionHem
else
	hemSetup = developmentHem

#--------- test configuration

hemSetup.tests = {}
hemSetup.tests.runner     = "karma"
hemSetup.tests.reporters  = "progress"
hemSetup.tests.frameworks = "jasmine"

#--------- setup reusable configuration for frontends

defaultFrontend =
	defaults: "spine"
	js:
		modules: []
		target: "public"
	css:
		target: "public"
	test:
		depends: "common"
		after: "require(\"lib/setup\");"

#--------- main configuration setup

config =

	# main hem configuration
	hem: hemSetup

	# common module that is shared across all frontends
	common:
		defaults: "spine"
		js:
			modules: [
				"jqueryify",
				"spine",
				"spine/lib/ajax",
				"spine/lib/route",
				"spine/lib/manager"
			]
		version:
			type: "package"
			files: [
				"./app1/public/index.html",
				"./app2/public/index.html",
				"./app3/public/index.html"
			]

	# all of the separate frontend applications
	app1   : defaultFrontend
	app2   : defaultFrontend
	app3   : defaultFrontend

#--------- export the configuration map for hem

module.exports.config = config

module.exports.customize = (hem) ->
	# provide hook to customize the hem instance,
	# called after config is parsed/processed.
	return
