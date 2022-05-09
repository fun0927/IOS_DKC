# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

post_install do |installer|
        installer.pods_project.build_configurations.each do |config|
                config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
        end
end

target 'D-WORK' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for D-WORK
  pod 'JGProgressHUD'
  # pod 'SDWebImage', '~> 5.0'
  pod 'SDWebImage'
  # pod 'Alamofire', '~> 5.4'
  pod 'Alamofire'
  pod 'Firebase/Core'
  pod 'Firebase/Messaging'
  # pod 'SQLite.swift', '~> 0.13.0'
  pod 'SQLite.swift'
  pod 'SideMenu'
  pod 'GoogleMaps'
  pod 'Firebase/Core'
  pod 'Firebase/Messaging'
  
  target 'D-WORKTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'D-WORKUITests' do
    # Pods for testing
  end

end
