# frozen_string_literal: true

require 'yaml'

# The place to store dirty secrets
class Config
  CONFIG = YAML.load_file(File.join(__dir__, '../config/config.yml'))
  class << self
    def url
      CONFIG['url']
    end

    def passphrase
      CONFIG['passphrase']
    end

    def sources
      CONFIG['sources']
    end
  end
end
