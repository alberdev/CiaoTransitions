Pod::Spec.new do |s|

# ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.platform = :ios
s.ios.deployment_target = '11'
s.name = "CiaoTransitions"
s.summary = "With Ciao you can make fancy custom transitions. Use it in your iOS projects to make push and modal transitions between view controllers"
s.requires_arc = true
s.version = "0.2.0"

# ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.license = { :type => "MIT", :file => "LICENSE" }

# ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.author = { "Alberto Aznar" => "info@alberdev.com" }
s.homepage = "https://github.com/alberdev/CiaoTransitions"

# ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.source = { :git => "https://github.com/alberdev/CiaoTransitions.git",
:tag => "#{s.version}" }

# ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.framework = "UIKit"

# ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.source_files = "CiaoTransitions/**/*.{swift}"

# ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

# s.resources = "CiaoTransitions/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# ――― Swift Version ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.swift_version = "4.2"

end
