require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?(:UI)

  module Helper
    class UpdateVersionNameHelper
      def self.show_message
        UI.message("Hello from the update_version_name plugin helper!")
      end
    end
  end
end
