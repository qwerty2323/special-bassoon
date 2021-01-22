# frozen_string_literal: true

require 'converters/sentinel_converter'
require 'converters/sniffer_converter'
require 'converters/loophole_converter'

# Fabric for converters
class Converter
  CONVERTERS = {
    sentinels: SentinelConverter,
    sniffers: SnifferConverter,
    loopholes: LoopholeConverter
  }.freeze

  def self.for(source)
    CONVERTERS[source]
  end
end
