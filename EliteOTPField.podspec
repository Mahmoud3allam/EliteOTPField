#
# Be sure to run `pod lib lint EliteOTPField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EliteOTPField'
  s.version          = '0.1.0'
  s.summary          = 'EliteOTPField is an easy and simple one type PIN view for iOS platform.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
"EliteOTField is a simple and easy way to build a One time PIN (OTP) view with many customization to fit every design"
  DESC

  s.homepage         = 'https://github.com/Mahmoud3allam/EliteOTPField'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mahmoud3allam' => 'allam40960@gmail.com' }
  s.source           = { :git => 'https://github.com/Mahmoud3allam/EliteOTPField.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.linkedin.com/in/mahmoud-allam-913183169/'

  s.ios.deployment_target = '10.0'

  s.source_files = 'EliteOTPField/Classes/**/*'
  s.swift_version = '5.0'

end
