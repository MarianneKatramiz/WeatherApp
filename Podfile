# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def all_pods
  pod 'SwiftLint',  '~> 0.38.2'
  pod 'Alamofire', '~> 4.9.1'
  pod 'IQKeyboardManagerSwift', '~> 6.5.4'
  pod 'Localize-Swift', '~> 3.1.0'
  pod 'SwiftMessages', '~> 7.0.1'
  pod 'RxSwift', '~> 5.0.1'
  pod 'RxCocoa', '~> 5.0.1'
  pod 'KeychainSwift', '~> 19.0.0'
  pod 'SwiftLocation', '~> 4.0'
end

target 'weather' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for weather
  all_pods

  target 'weatherTests' do
    inherit! :search_paths
    # Pods for testing
    all_pods
   
  end

  target 'weatherUITests' do
    # Pods for testing
  end

end
