require 'ruboty/shuden/route_api'
require 'ruboty/shuden/route_table'
require 'ruboty/shuden/actions/show_route'

module Ruboty
 module Shuden
  module Actions
   class SaveRoute < Ruboty::Actions::Base
    def call
     origin = message[:origin]
     dest = message[:dest]
     id = message.from
     table = RouteTable.new(id, message.robot.brain)
     err = []
     err << origin unless RouteAPI.validate_station(origin)
     err << dest unless RouteAPI.validate_station(dest)
     unless err.empty?
      message.reply(format('駅名が正しくありません: %s', err.join(', ')))
      return
           end
     table.save(origin, dest)
     message.reply('経路登録が完了しました')
     Ruboty::Shuden::Actions::ShowRoute.new(message).call
    end
   end
  end
 end
end
