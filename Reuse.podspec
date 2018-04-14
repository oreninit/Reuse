#
# Be sure to run `pod lib lint Reuse.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Reuse'
  s.version          = '0.1.0'
  s.summary          = 'Reuse is an easy to use library which helps tackle the reptitive task of populating UITableView/UICollectionView simply and elegantly'

  s.description      = <<-DESC
Most apps use some sort of a list UI, whether it be a table view or a collection view.
I often find myself repeating similar cell configuration code without conistency. After numerous assignments in `cellForRow`, countless `CellViewModel` and endless `configure(cell:with:)`, I decided to come up with a single, clean solution that will allow me to have a clear, simple configuration between a cell and an object that populates it without making them depend on each other.
    I wanted it to be fast, light on memory, minimize boilerplate and, if possible, ask it to take care of my list updates, inteaction and linking to the database.
I present, Reuse.
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
