# frozen_string_literal: true

require 'csv'
require 'date_formatter'

# Convert input signal from Sentinels to Zion
class SentinelConverter
  # route_id, node, index, time
  def convert(content)
    content.each_with_object([]) do |file, results|
      process(file, results)
    end
  end

  private

  def process(file, results)
    group(parse(file))
      .each { |routes| combine_routes(routes, results) }
  end

  def parse(file)
    CSV
      .parse(file.tr('"| ', ''), headers: :first_row)
      .map(&:to_h)
  end

  def group(routes)
    routes
      .group_by { |item| item['route_id'] }
      .values
  end

  def combine_routes(routes, results)
    routes.each_cons(2) do |route_pair|
      results << to_zion_route(route_pair)
    end
  end

  def to_zion_route(route_pair)
    start, finish = route_pair
    {
      start_node: start['node'],
      end_node: finish['node'],
      start_time: DateFormatter.format(start['time']),
      end_time: DateFormatter.format(finish['time'])
    }
  end
end
