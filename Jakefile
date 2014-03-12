var fs = require('fs');
var path = require('path');
var sh = require('execSync');

//Consts
var APP_NAME='MyApp'
var BUNDLE_NAME = 'com.domain.myapp'
var OUTPUT_PATH = path.normalize(__dirname + '/Output');

desc('Clean up generated environment.');
task('clean',function(){
	console.log('Begin cleaning project directory.');
	var cleanPath = __dirname + '/' + APP_NAME;
	deleteFolderRecursive(path.normalize(cleanPath));
	deleteFolderRecursive(OUTPUT_PATH);
	console.log('Finished cleaning.');
});

desc('Create the default Cordova project.');
task('create',['clean'],function(){
	console.log('Begin creating vanilla Cordova project.');
	issueCommand('cordova create ' + APP_NAME + ' ' + BUNDLE_NAME + ' ' + APP_NAME);
	issuePushPopCommand(APP_NAME,'cordova platform add ios');
	console.log('Finished creating project.');
});


desc('Install any Cordova plugins that are needed.');
task('plugins',['create'],function(){
	console.log('Begin installing plugins.');

	//Read in the plugins json
	var plugs = JSON.parse(fs.readFileSync('plugins.json'));

	//install plugins
	plugs.forEach(function(plug){
		issuePushPopCommand(APP_NAME,'cordova plugin add ' + plug);
	});

	console.log('Finished installing plugins.');
});

desc('Build Cordova.');
task('build',['plugins','create','migrate'],function(){
	console.log('Begin building Cordova project.');
	issuePushPopCommand(APP_NAME,'cordova build ios');
	console.log('Finished building Cordova project.');
});

desc('Run in emulator.');
task('run',['build'],function(){
	issuePushPopCommand(APP_NAME,'cordova run ios');
});

desc('Migrate www folder to Cordova project.');
task('migrate',['create'],function(){
	console.log('Begin migration to Cordova project.');
	var appPath = path.normalize(__dirname + '/' + APP_NAME);
	var wwwPath = path.normalize(appPath + '/www');

	issueCommand('rm -rf ' + wwwPath);

	var incWwwPath = './www'

	copyFiles(incWwwPath,appPath);

	
	console.log('Finished migration to Cordova project.');
});

desc('Modify the project to build for Testflight');
task('testflight-config',['build'],function(){
	console.log('Begin modifying Xcode project with Testflight profile.');
	issueCommand('ruby projmod.rb');
	console.log('Finished modifying Xcode project.');
});

desc('Build App IPA with Xcode.');
task('testflight-ipa',['testflight-config'],function(){
	console.log('Begin Xcode build.');

	var appPath = path.normalize(__dirname + '/' + APP_NAME + '/platforms/ios/build/Products/Release-iphoneos/' + APP_NAME + '.app');
	var ipaName = APP_NAME + '.ipa';
	var outputPath = path.normalize(__dirname + '/Output');
	var homePath = path.normalize('~/');
	

	//Clean the output directory
	fs.exists(outputPath,function(exists){
		ensureExists(exists,outputPath);
		issueCommand('/usr/bin/xcrun PackageApplication -v ' + appPath + ' -o ' + outputPath + '/' + ipaName + ' --embed ' + homePath + '"/Library/MobileDevice/Provisioning Profiles/Some-Provisioning-Profile.mobileprovision"' + ' --sign "iPhone Distribution: My App Cert"');
	})
	
	console.log('Finished Xcode build.');
});


var issuePushPopCommand = function(pushDir,command){
	issueCommand('pushd ' + pushDir + '; ' + command + '; popd;');
}

var ensureExists = function(exists,path){
	if(!exists){
		fs.mkdirSync(path);
	}
}

var issueCommand = function(command){
	
	var result = sh.exec(command.toString());
	console.log(result.stdout);
}

var copyFiles = function(source, dest){
	issueCommand('cp -r ' + source + ' ' + dest)
}

var deleteFolderRecursive = function(path) {
  if( fs.existsSync(path) ) {
    fs.readdirSync(path).forEach(function(file,index){
      var curPath = path + "/" + file;
      if(fs.lstatSync(curPath).isDirectory()) { // recurse
        deleteFolderRecursive(curPath);
      } else { // delete file
        fs.unlinkSync(curPath);
      }
    });
    fs.rmdirSync(path);
  }
};



