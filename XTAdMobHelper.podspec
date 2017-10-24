#
# Be sure to run `pod lib lint XTAdMobHelper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XTAdMobHelper'
  s.version          = '0.6.2'
  s.summary          = 'XTAdMobHelper is for integrating AdMob SDK more quickly.Maybe you only need to write just one line code'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Haha,it is really cool, you must be interested to integrate ad in your own app.Here is a good news.You can use this library to create Google Admob's banner,intersitial or reward video quickly.Use this library,you only need to write one line code ,then you can make money.
                       DESC

  s.homepage         = 'https://github.com/ronniechen888/XTAdMobHelper'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ronniechen888' => '576892817@qq.com' }
  s.source           = { :git => 'https://github.com/ronniechen888/XTAdMobHelper.git', :tag => '0.6.2' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.source_files = 'XTAdMobHelper/Classes/**/*'
  
  # s.resource_bundles = {
  #   'XTAdMobHelper' => ['XTAdMobHelper/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'Foundation'
  s.dependency 'Google-Mobile-Ads-SDK'
end
