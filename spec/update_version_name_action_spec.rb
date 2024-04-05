describe Fastlane::Actions::UpdateVersionNameAction do
  describe '#run' do
    it 'updates the versionName in build.gradle file' do
      gradle_file_path = 'spec/fixtures/build.gradle'

      gradle_file_content = <<-GRADLE
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

      File.write(gradle_file_path, gradle_file_content)

      fake_params = { gradle_file_path: gradle_file_path, version_name: '2.0.0' }

      Fastlane::Actions::UpdateVersionNameAction.run(fake_params)

      updated_gradle_file_content = File.read(gradle_file_path)

      expect(updated_gradle_file_content).to include('versionName "2.0.0"')

      begin
        File.delete(gradle_file_path)
      rescue Errno::ENOENT => e
        puts("The file was not found: #{e}")
      rescue StandardError => e
        puts("An error occurred when trying to delete the file: #{e}")
      end

      begin
        num_deleted = File.delete(gradle_file_path)
        puts("#{num_deleted} files were deleted.")
      rescue Errno::ENOENT => e
        puts("One of the files was not found: #{e}")
      rescue StandardError => e
        puts("An error occurred when trying to delete the files: #{e}")
      end
    end
  end
end
