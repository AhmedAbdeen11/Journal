# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Journal' do
  # Comment the next line if you don't want to use dynamic frameworks
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      end
    end
  end
  
  use_frameworks!

  # Pods for Journal
  pod 'Moya/RxSwift', '~> 12.0'
  pod 'SwiftyJSON'
  pod 'IQKeyboardManager'
  pod 'RSSelectionMenu'
  pod 'BEMCheckBox'
  pod 'SVProgressHUD'
  pod 'MaterialComponents/Buttons'
  pod 'MaterialComponents/TextControls+OutlinedTextFields'
  pod 'MaterialComponents/TextControls+FilledTextFields'
  pod 'Cosmos', '~> 23.0'
  pod 'FSCalendar'
  pod 'SwiftKeychainWrapper'
  pod 'SDWebImage'
  pod 'ObjectMapper'
  pod "BSImagePicker", "~> 3.1"
  pod 'Alamofire'
  pod "ImageSlideshow/Alamofire"
  pod "ReachabilitySwift"
  pod "SWSegmentedControl"

end
