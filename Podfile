# Uncomment this line to define a global platform for your project
# platform :ios, '6.0'
source 'https://github.com/CocoaPods/Old-Specs.git' #追記
platform :ios, '8.1' #追記
use_frameworks!

target 'GelanData' do
    
pod 'GoogleMaps'
pod 'Fabric'
pod 'TwitterKit'
pod 'RealmSwift'

end

target 'GelanDataTests' do

end

target 'GelanDataUITests' do

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |configuration|
            configuration.build_settings['SWIFT_VERSION'] = "3.0"
        end
    end
end
