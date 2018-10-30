source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
# ignore all warnings from all pods
inhibit_all_warnings!
# use required frameworks
use_frameworks!

def shared_pods
    pod 'Alamofire', '~> 4.0'
    pod 'SwiftyJSON', '~>3.1.0'
    pod 'PromiseKit', '~> 6.0'
end

target "SoundCloudMemory" do
    shared_pods
end

target "SoundCloudMemoryTests" do
    shared_pods
end

target "SoundCloudMemoryUITests" do
    shared_pods
end


