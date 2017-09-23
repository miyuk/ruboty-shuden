module Ruboty
  module Shuden
    class Transit
      attr_accessor :wait_time, :name, :platform

      def initialize
        @wait_time = nil
        @name = nil
        @platform = nil
      end

      def self.parse(transit_node)
        transit = Transit.new
        transit.wait_time = transit_node.css('td.tm').inner_text.strip
        transit.name = transit_node.css('td.nm > strong').inner_text.strip
        transit.platform = transit_node.css('td.ph > div').inner_text.strip
        transit
      end
    end
  end
end
