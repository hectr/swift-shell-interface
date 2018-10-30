Pod::Spec.new do |s|
  s.name         = 'ShellInterface'
  s.version      = '0.2.0'
  s.summary      = 'Shell interface'
  s.description  = <<-DESC
     A shell interface built as a thin abstraction layer on top of Foundation's `Process`.
  DESC
  s.homepage     = 'https://github.com/hectr/swift-shell-interface'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { 'Hèctor Marquès' => 'h@mrhector.me' }
  s.social_media_url   = 'https://twitter.com/elnetus'
  s.osx.deployment_target = '10.13'
  s.source       = { :git => 'https://github.com/hectr/swift-shell-interface.git', :tag => s.version.to_s }
  s.source_files = 'Sources/ShellInterface/**/*'
  s.frameworks   = 'Foundation'
end
