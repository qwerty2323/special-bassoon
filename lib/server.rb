# frozen_string_literal: true

require 'net/http'
require 'open-uri'

# Class (fasade) for GET and POST request
class Server
  class << self
    def get(link, params)
      uri = URI(link)
      uri.query = URI.encode_www_form(params)
      uri.open do |response|
        yield response
      end
    end

    def post(link, params)
      Net::HTTP.post_form(URI(link), params)
    end
  end
end
