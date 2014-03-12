phonegap-ios-ci-example
=======================

Jakefile is currently only going to work on Mac. We will try to make as many commands as possible Windows friendly.

Required global installs, may need sudo  

	npm install -g cordova  
	npm install -g jake  
	npm install -g ios-deploy  
	npm install -g plugman
	gem install xcoder  


How to add plugins
------------------
Plugins are installed from their git repositories. The `plugins.json` file is just an array of those git repositories which get loaded during the Cordova build.   
##### Example:
	
	{
		"https://github.com/shazron/TestFlightPlugin.git",
		"https://github.com/phonegap-build/BarcodeScanner.git"
	}
	
How to build
------------
For most cases you will want one of the following.

	npm install
	jake build
	
or

	npm install
	jake run
	
If you want to see all of your options `jake --tasks` will show the menu
