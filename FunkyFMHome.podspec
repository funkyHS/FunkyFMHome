
Pod::Spec.new do |s|
  s.name             = 'FunkyFMHome'
  s.version          = '0.1.0'
  s.summary          = 'FunkyFMHome'

  s.description      = <<-DESC
TODO: FunkyFMHome FM的首页模块
                       DESC

  s.homepage         = 'https://github.com/funkyHS/FunkyFMHome'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'funkyHS' => 'hs1024942667@163.com' }
  s.source           = { :git => 'https://github.com/funkyHS/FunkyFMHome.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'FunkyFMHome/Classes/**/*'
  
  # s.resource_bundles = {
  #   'FunkyFMHome' => ['FunkyFMHome/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'


    s.dependency 'FunkySegmentBar'
    s.dependency 'FunkyFMHomeRecommend'
    s.dependency 'FunkyFMBase/Base'
    s.dependency 'MJExtension'
    s.dependency 'FunkyFMBase/Network'

#s.dependency 'FunkyScrollPicView'
#s.dependency 'FunkyMenueView'



end
