# frozen_string_literal: true

require 'csv'
require 'date_formatter'
# Converts signal from Sniffer to Zion
class SnifferConverter
  # node_time_id, start_node, end_node, duration
  # route_id, time, timezone
  def convert(content)
    destinations, timetable = parse(content)
    combined_routes = combine(destinations, timetable)
    valid_routes = validate(combined_routes)
    valid_routes.map { |route| to_zion_route(route) }
  end

  private

  def parse(content)
    content.map do |file|
      CSV
        .parse(file.tr('"| ', ''), headers: :first_row)
        .map(&:to_h)
    end
  end

  def validate(routes)
    routes.take_while { |hash_route| valid(hash_route) }
  end

  def valid(hash_route)
    %w[route_id time time_zone].all? do |key|
      hash_route.key? key
    end
  end

  def combine(destinations, timetable)
    (destinations + timetable)
      .group_by { |item| item['route_id'] || item['node_time_id'] }
      .map { |_, array| array.reduce(&:merge) }
  end

  def start_time(record)
    DateTime.parse(
      record['time'] + record['time_zone']
    )
  end

  def end_time(route)
    start_time(route) +
      route['duration_in_milliseconds'].to_i / 1000
  end

  def to_zion_route(route)
    {
      start_node: route['start_node'],
      end_node: route['end_node'],
      start_time: convert_datetime(start_time(route)),
      end_time: convert_datetime(end_time(route))
    }
  end

  def convert_datetime(datetime)
    DateFormatter.format(datetime.to_s)
  end
end
