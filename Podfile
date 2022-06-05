source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!
platform :ios, '13.0'
inhibit_all_warnings!

target 'TicketOil' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TicketOil
  pod 'Alamofire', '5.4.1'
  pod 'Swinject', '2.7.1'
  pod 'SwiftGen'
  pod 'SnapKit'
  pod 'PromiseKit'
  pod 'Reusable'
  pod 'RxCocoa'
  pod 'RxSwift'
  pod 'KeychainAccess'
  pod 'Kingfisher'
  pod 'IQKeyboardManagerSwift'
  pod 'Cache', '~> 6'
  pod 'SwiftDate'
  pod 'YandexMapsMobile', '4.1.0-lite'

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings.delete('CODE_SIGNING_ALLOWED')
    config.build_settings.delete('CODE_SIGNING_REQUIRED')
    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
  end
end
