Pod::Spec.new do |s|
  s.name             = 'Reuse'
  s.version          = '0.1.0'
  s.summary          = 'A library to simplify the process of populating table views and collection views'

  s.description      = <<-DESC
Reuse is a simple library which helps tackle the tedious task of populating UITableView/UICollectionView simply and elegantly.
DESC
  s.homepage         = 'https://github.com/oreninit/Reuse'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Oreninit' => 'oreninit@gmail.com' }
  s.source           = { :git => 'https://github.com/oreninit/Reuse.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/oreninit'
  s.ios.deployment_target = '9.3'
  s.source_files = 'Reuse/Classes/**/*'
  s.frameworks = 'UIKit'
end
