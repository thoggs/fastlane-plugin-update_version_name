require 'fastlane_core'

describe Fastlane::Actions::UpdateVersionNameAction do
  describe '#run' do
    before(:each) do
      @gradle_file_path = 'spec/fixtures/build.gradle'

      FileUtils.mkdir_p(File.dirname(@gradle_file_path))

      @gradle_file_content = <<-GRADLE
        apply plugin: 'com.android.application'

        android {
          compileSdkVersion 29
          defaultConfig {
          applicationId "com.example.app"
          minSdkVersion 16
          targetSdkVersion 29
          versionCode 1
          versionName "1.0.0"
        }
      }
      GRADLE

      File.write(@gradle_file_path, @gradle_file_content)
    end

    it 'updates the versionName in build.gradle file' do
      fake_params = { gradle_file_path: @gradle_file_path, version_name: '2.0.0' }
      Fastlane::Actions::UpdateVersionNameAction.run(fake_params)
      updated_gradle_file_content = File.read(@gradle_file_path)
      expect(updated_gradle_file_content).to include('versionName "2.0.0"')
    end

    after(:each) do
      FileUtils.rm_f(@gradle_file_path)
    end
  end
end
