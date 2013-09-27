Pod::Spec.new do |s|
  s.name         = "TSSlideMenu"
  s.version      = "0.0.2"
  s.summary      = "Top Slide-out navigation menu"
  s.homepage     = "https://github.com/TheSooth/TSSlideMenu"

  s.license      = { :type => 'Apache License 2.0', :file => 'LICENSE' }

  s.author       = { "TheSooth" => "thesooth@aol.com" }

  s.source       = { :git => "https://github.com/TheSooth/TSSlideMenu.git", :tag => "0.0.1" }
  s.platform     = :ios, '5.0'
  s.source_files = 'TSSlideMenu/Code', 'TSSlideMenu/Code/**/*.{h,m}'
  s.resources = 'TSSlideMenu/**/*.png'
  s.framework  = 'UIKit'
  s.requires_arc = true
end
