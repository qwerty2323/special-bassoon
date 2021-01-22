# frozen_string_literal: true

require 'zip'

# Class (fasade) for extracting archive
class Archive
  class << self
    def extract(archive)
      Zip::File.open_buffer(archive) do |zip_files|
        yield(input_stream(zip_files))
      end
    end

    def filter(files)
      files.select do |file|
        file.name.end_with?('.csv', '.json')
      end
    end

    def input_stream(files)
      filter(files).collect do |file|
        file.get_input_stream.read
      end
    end
  end
end
