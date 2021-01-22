# frozen_string_literal: true

require 'server'
require 'config'

describe Server do
  let(:source) { 'sentinels' }
  let(:get_params) do
    {
      passphrase: Config.passphrase,
      source: source
    }
  end
  let(:post_params) do
    {
      passphrase: Config.passphrase,
      source: source,
      start_node: 'alpha',
      end_node: 'beta',
      start_time: '2030-12-31T13:00:06',
      end_time: '2030-12-31T13:00:07'
    }
  end
  let(:link) { Config.url }

  it 'recieves content when getting' do
    subject.class.get(link, get_params) do |content|
      expect(content).not_to be_nil
    end
  end

  it 'receives expected response when posting' do
    response = subject.class.post(link, post_params)
    expect(response.code).to eql '201'
    expect(response.body).to include(
      'Targeting... almost there. Lock! I got him!'
    )
    expect(response.body).to include(
      'Welcome to the real world, Neo.'
    )
  end
end
