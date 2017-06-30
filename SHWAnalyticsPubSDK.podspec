Pod::Spec.new do |s|
  s.name         = "SHWAnalytics"
  s.version      = "0.1.2"
  s.summary      = "Analytics framework."
  s.homepage     = "https://code.aliyun.com/xhzy-ios/SHWAnalytics"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "yangyang" => "yangyang@shuwen.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://code.aliyun.com/xhzy-ios/SHWAnalytics.git", :tag => "#{s.version}" }
  s.vendored_framework = "SHWAnalyticsSDK.framework"
  s.dependency 'UTDID'
  s.requires_arc = true
end
