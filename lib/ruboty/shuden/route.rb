require 'nokogiri'

require 'ruboty/shuden/section'
require 'ruboty/shuden/transit'
require 'ruboty/shuden/way'

module Ruboty
  module Shuden
    class Route
      attr_accessor :sections

      def initialize
        @sections = []
      end

      def self.parse(route_node)
        route = Route.new
        transits = []
        ways = []
        route_node.css('tr.eki').each do |transit_node|
          transits << Transit.parse(transit_node)
        end
        route_node.css('tr.rosen').each do |way_node|
          ways << Way.parse(way_node)
        end
        # 道中の数+降車分だけ乗り換えがある
        ways.each_index do |i|
          section = Section.new
          section.origin = transits[i]
          section.dest = transits[i + 1]
          section.way = ways[i]
          route.sections << section
        end
        route
      end

      def pretty
        text = '```'
        @sections.each do |section|
          origin = section.origin
          way = section.way
          dest = section.dest
          text += format("%s(%s) -- %s[%s(%s)] -> %s(%s)\n",
                         origin.name, origin.platform, way.line_name, way.time,
                         way.duration, dest.name, dest.platform)
        end
        text += "```\n"
        text
      end
    end
  end
end
