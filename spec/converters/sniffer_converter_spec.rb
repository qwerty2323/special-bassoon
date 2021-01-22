# frozen_string_literal: true

require('converters/sniffer_converter')

SNIFFER_CONTENT_PATH = [
  File.expand_path('../data/sniffers/node_times.csv', __dir__),
  File.expand_path('../data/sniffers/routes.csv', __dir__),
  File.expand_path('../data/sniffers/sequences.csv', __dir__)
].freeze

describe SnifferConverter do
  it_behaves_like 'converter',
                  SNIFFER_CONTENT_PATH
                    .map { |file| File.open(file) }
    .map(&:read),
                  [{
                    start_node: 'lambda',
                    end_node: 'tau',
                    start_time: '2030-12-31T13:00:06',
                    end_time: '2031-01-01T13:00:06'
                  },
                   {
                     start_node: 'tau',
                     end_node: 'psi',
                     start_time: '2030-12-31T13:00:07',
                     end_time: '2031-01-01T13:00:07'
                   },
                   {
                     start_node: 'psi',
                     end_node: 'omega',
                     start_time: '2030-12-31T13:00:00',
                     end_time: '2031-01-01T13:00:00'
                   }]
end
