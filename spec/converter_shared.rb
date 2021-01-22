# frozen_string_literal: true

shared_examples 'a factory' do |source|
  it "returns #{source.capitalize} converter" do
    expect(subject.class.for(source.to_sym).new).to respond_to(:convert)
  end
end
