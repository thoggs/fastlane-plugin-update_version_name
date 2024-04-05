require 'fastlane/plugin/update_version_name/version'

module Fastlane
  module UpdateVersionName
    def self.all_classes
      Dir[File.expand_path('**/{actions,helper}/*.rb', File.dirname(__FILE__))]
    end
  end
end

Fastlane::UpdateVersionName.all_classes.each do |current|
  require current
end
