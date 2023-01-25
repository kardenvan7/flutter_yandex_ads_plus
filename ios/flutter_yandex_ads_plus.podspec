#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_yandex_ads_plus.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_yandex_ads_plus'
  s.version          = '0.6.0'
  s.summary          = 'Flutter Yandex Ads.'
  s.description      = <<-DESC
Flutter Yandex Ads.
                       DESC
  s.homepage         = 'https://github.com/kardenvan7/flutter_yandex_ads_plus'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'kardenvan' => 'glushkovlad98@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'YandexMobileAds'
  s.dependency 'YandexMobileAdsInstream'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
