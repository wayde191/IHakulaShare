Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '7.1'
s.name = "IHakulaShare"
s.summary = "IHakulaShare can help you share message to QQ, WeChat, Qzone and Sina easily."
s.requires_arc = true

# 2
s.version = "0.6.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Wayde Sun" => "wsun191@gmail.com" }

# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://github.com/wayde191/IHakulaShare"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/wayde191/IHakulaShare.git", :tag => "#{s.version}"}

# 7
s.framework = "UIKit", "Foundation", "MessageUI", "CoreTelephony", "SystemConfiguration"
s.library = "z", "icucore"

s.vendored_frameworks = "IHakulaShare/**/*.framework"
s.vendored_libraries = "IHakulaShare/**/*.a"

# 8
s.source_files = "IHakulaShare/*.{h,m}"
s.resources = "IHakulaShare/**/*.{xib,bundle}"

end