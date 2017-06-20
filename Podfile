use_frameworks!
target 'AZ-Social' do
pod 'SwipeViewController'
pod 'TRMosaicLayout'
pod 'RGPageViewController', :git => 'https://github.com/eRGoon/RGPageViewController.git', :tag => '1.0.0'
pod "BSImagePicker", "~> 2.4"
pod 'Socket.IO-Client-Swift' # Or latest version

end
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
