#
# Be sure to run `pod lib lint GQPaymentIOSSDKNative.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GQPaymentIOSSDKNative'
  s.version          = '0.1.8'
  s.summary          = 'GrayQuest Education Finance Pvt. Ltd. iOS SDK'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
"The SDK is an integrated flow in ERP that will enable users to avail multiple payment options in a seamless manner, with faster integration and deployment times."
                       DESC

  s.homepage         = 'https://github.com/grayquest-finance/gq_payment_ios_sdk_native'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'grayquest-finance' => 'developer@grayquest.com' }
  s.source           = { :git => 'https://github.com/grayquest-finance/gq_payment_ios_sdk_native.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '15.0'
  s.swift_versions = "5.0"

  s.dependency 'CashfreePG', '~> 2.0.3'
  s.dependency 'razorpay-pod', '1.2.5'
  s.dependency 'Easebuzz', '~> 1.1'
  
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  
#   s.source_files = 'GQPaymentIOSSDKNative/Classes/**/*'
#   s.resources = ["GQPaymentIOSSDKNative/Assets/*.xcassets", "GQPaymentIOSSDKNative/Assets/Fonts/**/*.ttf"]

   s.vendored_frameworks = 'GQPaymentIOSSDKNative.xcframework'
   s.exclude_files = 'BuildFramework.sh'
                
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
