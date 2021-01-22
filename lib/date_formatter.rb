# frozen_string_literal: true

# Unifies date from different timezones
module DateFormatter
  def format(date)
    DateTime.parse(date).new_offset('+00:00').strftime('%FT%T')
  end

  module_function :format
end
