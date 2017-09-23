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
    text = ''
    @sections.each do |section|
     text += format('%s(%s) -- ', section.origin.name, section.origin.platform)
     text += format('%s[%s(%s)] -> ', section.way.line_name, section.way.time, section.way.duration)
    end
    last = @sections.last
    text += format('%s(%s)', last.dest.name, last.dest.platform) if last
    text
   end
  end
 end
end
