
Pod::Spec.new do |s|
  
  s.name             = 'RxSwiftX'
  s.version          = '0.6.0'
  s.summary          = 'A short description of RxSwiftX.'
  s.homepage         = 'https://github.com/Pircate/RxSwiftX'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pircate' => 'gao497868860@163.com' }
  s.source           = { :git => 'https://github.com/Pircate/RxSwiftX.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.default_subspec = "Core"
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.swift_version = '5.0'
  
  s.subspec 'Core' do |ss|
      
      ss.source_files = 'RxSwiftX/Classes/Swift/', 'RxSwiftX/Classes/Cocoa/'
      
  end
  
  s.subspec 'DataSources' do |ss|
      
      ss.source_files = 'RxSwiftX/Classes/DataSources/'
      ss.dependency 'RxDataSources'
      
  end
  
  s.subspec 'MJRefresh' do |ss|
      
      ss.source_files = 'RxSwiftX/Classes/MJRefresh/'
      ss.dependency 'MJRefresh'
  
  end
  
end
