=begin
   Copyright 2014 John Moberly

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
=end

require 'xcoder'

APP_NAME = 'MyApp'

project = Xcode.project('./' + APP_NAME + '/platforms/ios/' + APP_NAME + '.xcodeproj')
config = project.target(APP_NAME).config('Release')
builder = config.builder
builder.profile = File.expand_path('~/Library/MobileDevice/Provisioning Profiles/some-provisioning-profile.mobileprovision')
builder.identity = 'iPhone Distribution: My Cert Name'
builder.clean
builder.build