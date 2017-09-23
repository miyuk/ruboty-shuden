module Ruboty
  module Shuden
    class Way
      attr_accessor :time, :duration, :line_name, :boarding_position, :distance

      def initialize
        @time = nil
        @duration = nil
        @line_name = nil
        @boarding_position = nil
        @distance = nil
      end

      def self.parse(way_node)
        way = Way.new
        way.time = way_node.css('td.tm > b').inner_text.strip
        way.duration = way_node.at_css('td.tm').xpath('text()').text.strip
        way.line_name = way_node.css('td.rn > div').inner_text.strip
        way.boarding_position = way_node.css('td.ph').inner_text.strip
        way.distance = way_node.css('td.km').inner_text.strip
        way
      end
    end
  end
end
