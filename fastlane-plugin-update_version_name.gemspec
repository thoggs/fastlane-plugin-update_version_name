lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/update_version_name/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-update_version_name'
  spec.version       = Fastlane::UpdateVersionName::VERSION
  spec.author        = 'Thiago Rodrigues'
  spec.email         = 'thiago@uliving.com.br'
  spec.summary       = 'Updates the versionName in the build.gradle file of an Android project'
  spec.homepage      = 'https://github.com/thoggs/fastlane-plugin-update_version_name'
  spec.license       = "MIT"
  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.require_paths = ['lib']
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.required_ruby_version = '>= 2.6'
end
