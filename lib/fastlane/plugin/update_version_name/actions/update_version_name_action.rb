require 'fastlane/action'
require_relative '../helper/update_version_name_helper'

require 'fileutils'

module Fastlane
  module Actions
    class UpdateVersionNameAction < Action
      def self.run(params)
        gradle_file_path = params[:gradle_file_path]
        version_name = params[:version_name]

        UI.message("Plugin update_version_name is looking for gradle file at path: #{gradle_file_path}")

        unless File.exist?(gradle_file_path)
          UI.user_error!("Could not find gradle file at path '#{gradle_file_path}'")
        end

        version_name_line_regex = /^\s*versionName\s*['"](.*)['"]$/
        file_content = File.read(gradle_file_path)
        new_content = ""
        version_name_updated = false

        file_content.each_line do |line|
          if version_name_line_regex.match?(line)
            new_line = line.gsub(version_name_line_regex, "    versionName \"#{version_name}\"")
            new_content += new_line
            version_name_updated = true
            UI.message("Updated versionName to #{version_name}")
          else
            new_content += line
          end
        end

        if version_name_updated
          File.open(gradle_file_path, 'w') { |file| file.puts(new_content) }
          UI.success("Successfully updated versionName in gradle file to #{version_name}")
        else
          UI.important("No versionName found in gradle file to update")
        end
      end

      def self.description
        "Updates the versionName in your project's gradle file to the specified value"
      end

      def self.authors
        ["Codesumn"]
      end

      def self.return_value
        "The new versionName after it has been updated in the gradle file"
      end

      def self.details
        "Use this action to update the versionName in your Android project's gradle file directly from your Fastlane script."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :gradle_file_path,
            env_name: "FL_UPDATE_VERSION_NAME_GRADLE_FILE_PATH",
            description: "The relative path to the gradle file containing the versionName you want to update",
            type: String
          ),
          FastlaneCore::ConfigItem.new(
            key: :version_name,
            env_name: "FL_UPDATE_VERSION_NAME_VERSION_NAME",
            description: "The new versionName to set in your gradle file",
            type: String
          )
        ]
      end

      def self.is_supported?(platform)
        platform == :android
      end
    end
  end
end
