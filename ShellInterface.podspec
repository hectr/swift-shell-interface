Pod::Spec.new do |s|
  s.name         = "ShellInterface"
  s.version      = "0.0.1"
  s.summary      = "Shell interface"
  s.description  = <<-DESC
     A shell interface built as a thin abstraction layer over Foundation's `Process`.
  DESC
  s.homepage     = "https://github.com/hectr/swift-shell-interface"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Hèctor Marquès" => "h@mrhector.me" }
  s.social_media_url   = "https://twitter.com/elnetus"
  s.osx.deployment_target = "10.9"
  s.source       = { :git => "https://github.com/hectr/swift-shell-interface.git", :tag => s.version.to_s }
  s.source_files = "Sources/**/*"
  s.frameworks   = "Foundation"
end
