#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint jwplayer.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'jwplayer'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*', 'JWPlayerKit.xcframework/**/*'
  s.dependency 'Flutter'
  s.dependency 'JWPlayerKit'
  s.vendored_frameworks = 'myFramework.framework' 'JWPlayerKit.xcframework'
  s.platform = :ios, '10.0'
  s.static_framework = true
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.swift_version = '5.0'
end
