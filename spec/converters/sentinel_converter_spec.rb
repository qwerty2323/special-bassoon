# frozen_string_literal: true

require('converters/sentinel_converter')

SENTINEL_CONTENT_PATH = [
  File.expand_path('../data/sentinels/routes.csv', __dir__)
].freeze

describe SentinelConverter do
  it_behaves_like 'converter',
                  SENTINEL_CONTENT_PATH
                    .map { |file| File.open(file) }
    .map(&:read),
                  [{
                    start_node: 'alpha',
                    end_node: 'beta',
                    start_time: '2030-12-31T13:00:01',
                    end_time: '2030-12-31T13:00:02'
                  },
                   {
                     start_node: 'beta',
                     end_node: 'gamma',
                     start_time: '2030-12-31T13:00:02',
                     end_time: '2030-12-31T13:00:03'
                   },
                   {
                     start_node: 'delta',
                     end_node: 'beta',
                     start_time: '2030-12-31T13:00:02',
                     end_time: '2030-12-31T13:00:03'
                   },
                   {
                     start_node: 'beta',
                     end_node: 'gamma',
                     start_time: '2030-12-31T13:00:03',
                     end_time: '2030-12-31T13:00:04'
                   }]
end
