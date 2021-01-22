# frozen_string_literal: true

require 'json'
require 'date_formatter'

# Converts signal from Loophole to Zion
class LoopholeConverter
  # node_pairs (id, start_node, end_node)
  # routes (start_time, end_time, route_id, node_pair_id)
  def convert(content)
    node_pairs, routes = parse(content)
    combined_routes = combine(node_pairs, routes)
    valid_routes = validate(combined_routes)
    valid_routes.map { |item| to_zion_route(item) }
  end

  private

  def parse(content)
    content.flat_map do |file|
      JSON.parse(file).values
    end
  end

  def combine(node_pairs, routes)
    (routes + node_pairs)
      .group_by { |item| item['node_pair_id'] || item['id'] }
      .map { |_, array| array.reduce(&:merge) }
  end

  def validate(routes)
    routes.take_while { |hash_route| valid(hash_route) }
  end

  def valid(hash_route)
    %w[start_node end_node start_time end_time].all? do |key|
      hash_route.key? key
    end
  end

  def to_zion_route(item)
    {
      start_node: item['start_node'],
      end_node: item['end_node'],
      start_time: DateFormatter.format(item['start_time']),
      end_time: DateFormatter.format(item['end_time'])
    }
  end
end
