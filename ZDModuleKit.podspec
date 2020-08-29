Pod::Spec.new do |s|
  s.name             = 'ZDModuleKit'
  s.version          = '1.0.0'
  s.summary          = 'ZDModuleKit:组件生命周期管理'
  s.description      = <<-DESC
ZDModuleKit:组件生命周期管理:管理组件.
                       DESC

  s.homepage         = 'https://gitee.com/DevdragonLi/ZDModuleKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DevDragonLi' => 'dragonli_52171@163.com' }
  s.source           = { :git => 'https://github.com/DevdragonLi/ZDModuleKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'ZDModuleKit/Classes/**/*'
  
  s.public_header_files = 'ZDModuleKit/Classes/ZDModuleKit.h','ZDModuleKit/Classes/Core/ZDModule.h'
  
end
