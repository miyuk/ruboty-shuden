require 'time'

require 'ruboty/shuden/route_api'
require 'ruboty/shuden/route_table'

module Ruboty
 module Shuden
  module Actions
   class ShowLastTrain < Ruboty::Actions::Base
    def call
     now = Time.now
     # 0時から2時なら終電が残っているはず
     today = now.to_date
     today -= 1 if now.hour.between?(0, 2)
     id = message.from
     name = message.from_name
     table = RouteTable.new(id, message.robot.brain)
     origin, dest = table.load
     unless origin && dest
      message.reply(format("%sの経路はありません\nsave routeで登録してください", name))
      return
     end
     routes = RouteAPI.search_last_train(today, origin, dest)
     routes.each do |route|
      message.reply(route.pretty)
     end
   end
   end
  end
 end
end
