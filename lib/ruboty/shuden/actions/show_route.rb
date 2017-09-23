require 'ruboty/shuden/route_table'

module Ruboty
 module Shuden
  module Actions
   class ShowRoute < Ruboty::Actions::Base
    def call
     name = message.from_name
     table = RouteTable.new(name, message.robot.brain)
     origin, dest = table.load
     unless origin && dest
      message.reply(format("%sの経路はありません\nsave routeで登録してください", name))
      return
      end
     message.reply(format("%sの経路\n%s -> %s", name, origin, dest))
    end
   end
  end
 end
end
