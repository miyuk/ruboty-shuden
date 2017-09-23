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
          name = message.from_name
          table = RouteTable.new(name, message.robot.brain)
          origin, dest = table.load
          unless origin && dest
            message.reply(format("%sの経路はありません\nsave routeで登録してください", name))
            return
          end
          routes = RouteAPI.search_last_train(today, origin, dest)
          return unless routes
          reply = format("*%sの終電[%s -> %s](%s)*\n", name, origin, dest, today)
          routes.each_with_index do |route, i|
            reply += format(">経路%d\n", i + 1)
            reply += route.pretty
          end
          message.reply(reply)
       end
      end
    end
  end
end
