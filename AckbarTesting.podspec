Pod::Spec.new do |s|
  s.name         = 'AckbarTesting'
  s.version      = '1.0.0'
  s.summary      = 'Testing helpers for detecting Ackbar assertion failures.'
  s.homepage     = 'https://github.com/square/ackbar'
  s.license      = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }
  s.authors      = 'Square, Inc.'
  s.source       = { :git => 'https://github.com/square/ackbar.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.ios.framework = 'Foundation'
  s.ios.framework = 'XCTest'

  s.dependency 'AckbarAssertions'
  
  s.source_files = 'Ackbar/Testing'
end
