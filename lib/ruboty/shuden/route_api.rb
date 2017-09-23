require 'uri'
require 'open-uri'
require 'nokogiri'

require 'ruboty/shuden/route'

module Ruboty
 module Shuden
  class RouteAPI
   ROUTE_SEARCH_URL = 'https://www.jorudan.co.jp/norikae/cgi/nori.cgi'.freeze
   STATION_SEARCH_URL = 'https://www.jorudan.co.jp/ekiin/cgi-bin/edicc.cgi'.freeze

   def self.validate_station(station)
    candidates = RouteAPI.search_station(station)
    # 複数候補が見つかるときもあるため
    !candidates.empty? && (candidates[0] == station)
   end

   # 駅名の候補検索
   def self.search_station(station)
    url = URI.parse(STATION_SEARCH_URL)
    params = {}
    params['q'] = station
    url.query = URI.encode_www_form(params)
    html = open(url).read
    # 取得したjsonファイルが壊れているためパース
    candidates = []
    html.scan(/\[\'(.+?)\'\]/) do |matched|
     candidates << matched[0].force_encoding('UTF-8')
    end
    candidates
   end

   def self.search_last_train(date, origin, dest)
    # パラメタ挿入
    url = URI.parse(ROUTE_SEARCH_URL)
    params = {}
    params['eki1'] = origin
    params['eki2'] = dest
    params['Dym'] = date.strftime('%Y%m')
    params['Ddd'] = date.strftime('%d')
    params['Cway'] = 3
    params['S'] = '検索'
    url.query = URI.encode_www_form(params)

    charset = nil
    html = open(url) do |f|
     charset = f.charset
     f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)
    results = doc.css('div#results')
    routes = []
    results.css('div.route').each do |route_node|
     route = Route.parse(route_node)
     routes << route
    end
    routes
   end
  end
 end
end
