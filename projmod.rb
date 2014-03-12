require 'xcoder'

APP_NAME = 'MyApp'

project = Xcode.project('./' + APP_NAME + '/platforms/ios/' + APP_NAME + '.xcodeproj')
config = project.target(APP_NAME).config('Release')
builder = config.builder
builder.profile = File.expand_path('~/Library/MobileDevice/Provisioning Profiles/some-provisioning-profile.mobileprovision')
builder.identity = 'iPhone Distribution: My Cert Name'
builder.clean
builder.build