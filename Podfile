platform :ios, '15.0'

use_frameworks!

workspace 'WWDC2021'

def common_pods
    pod 'SnapKit', '~> 5.0'
end

target 'WWDC2021' do
    project 'WWDC2021/WWDC2021.xcodeproj'
    
    common_pods
end

target 'WWDC2021Framework' do
    project 'WWDC2021Framework/WWDC2021Framework.xcodeproj'

    common_pods
end
