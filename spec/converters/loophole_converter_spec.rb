# frozen_string_literal: true

require 'converters/shared_examples'
require 'converters/loophole_converter'

LOOPHOLE_CONTENT_PATH = [
  File.expand_path('../data/loopholes/node_pairs.json', __dir__),
  File.expand_path('../data/loopholes/routes.json', __dir__)
].freeze

describe LoopholeConverter do
  it_behaves_like 'converter',
                  LOOPHOLE_CONTENT_PATH
                    .map { |file| File.open(file) }
    .map(&:read),
                  [{
                    start_node: 'gamma',
                    end_node: 'theta',
                    start_time: '2030-12-31T13:00:04',
                    end_time: '2030-12-31T13:00:05'
                  },
                   {
                     start_node: 'theta',
                     end_node: 'lambda',
                     start_time: '2030-12-31T13:00:05',
                     end_time: '2030-12-31T13:00:06'
                   },
                   {
                     start_node: 'beta',
                     end_node: 'theta',
                     start_time: '2030-12-31T13:00:05',
                     end_time: '2030-12-31T13:00:06'
                   },
                   {
                     start_node: 'theta',
                     end_node: 'lambda',
                     start_time: '2030-12-31T13:00:06',
                     end_time: '2030-12-31T13:00:07'
                   }]
end
