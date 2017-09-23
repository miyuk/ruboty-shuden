module Ruboty
 module Shuden
  class RouteTable
   # slackではmessage.fromはチャンネル名になるためmessage.from_nameをidとする
   def initialize(user_name, brain)
    @user_name = user_name
    @brain = brain
   end

   def save(origin, dest)
    route = { origin: origin, dest: dest }
    @brain.data[@user_name] = { route: route }
   end

   def load
    data = @brain.data[@user_name]
    return nil, nil unless data
    route = data[:route]
    return nil, nil unless route
    [route[:origin] || nil, route[:dest] || nil]
   end
  end
 end
end
