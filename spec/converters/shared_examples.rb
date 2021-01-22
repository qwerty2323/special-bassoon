# frozen_string_literal: true

shared_examples 'converter' do |content, expected|
  let(:content) { content }
  let(:actual) { subject.convert(content) }
  let(:expected) { expected }
  it 'returns valid signal' do
    expect(actual).to include(expected[0])
  end
end
