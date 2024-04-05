describe Fastlane::Actions::UpdateVersionNameAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The update_version_name plugin is working!")

      Fastlane::Actions::UpdateVersionNameAction.run(nil)
    end
  end
end
