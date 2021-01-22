# frozen_string_literal: true

shared_examples 'an archive utility' do |source, expected_count|
  let(:filepath) { File.join(__dir__, "data/#{source}.zip") }
  it "can extract files from #{source}.zip" do
    File.open(filepath) do |io|
      subject.class.extract(io) do |files|
        expect(files.count).to eq expected_count
      end
    end
  end
end
