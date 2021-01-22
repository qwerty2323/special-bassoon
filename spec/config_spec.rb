# frozen_string_literal: true

require 'config'

describe Config do
  it 'has three data source' do
    expect(subject.class.sources).to include(
      'sentinels',
      'sniffers',
      'loopholes'
    )
  end
end
