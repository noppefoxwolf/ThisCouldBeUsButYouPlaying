require 'fileutils'
require 'pathname'

module Pod
  class PlaygroundGenerator
    
    TEMPLATE_DIR = Pathname.new('Library/Xcode/Templates/File Templates/Playground/Blank.xctemplate')
    TEMPLATE_NAME = Pathname.new('___FILEBASENAME___.playground')

    def initialize(platform)
      @template = self.class.template_dir + TEMPLATE_NAME
    end

    def generate(name)
      FileUtils.cp_r(@template, "#{name}.playground")
      Pathname.new("#{name}.playground")
    end

    def self.template_dir
      xcode = Pathname.new(`xcode-select -p`.strip)
      xcode + TEMPLATE_DIR
    end

    def self.major_version
      `xcodebuild -version`.split("\n").first.split(' ')[1].split('.').first.to_i
    end
  end
end
