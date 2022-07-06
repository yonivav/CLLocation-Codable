Pod::Spec.new do |spec|
  spec.name          = 'CLLocationWrapper'
  spec.version       = '1.0.0'
  spec.license       = { :type => 'MIT' }
  spec.homepage      = 'https://github.com/yonivav/CLLocationWrapper'
  spec.authors       = { 'Yoni Vizel' => 'yonivav@gmail.com' }
  spec.summary       = 'A wrapper for CLLocation for encoding and decoding CLLocation.'
  spec.swift_version = '5'
  spec.platform      = :ios, "12.0"
  spec.source        = { :git => 'https://github.com/yonivav/CLLocationWrapper.git', :tag => '1.0.0' }
  spec.source_files  = 'Sources/**/*.swift'
  spec.framework     = 'CLLocationWrapper'
end
