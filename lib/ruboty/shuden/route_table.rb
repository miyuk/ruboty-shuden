module Ruboty
 module Shuden
  class RouteTable
   def initialize(user_id, brain)
    @user_id = user_id
    @brain = brain
   end

   def save(origin, dest)
    route = { origin: origin, dest: dest }
    @brain.data[@user_id] = { route: route }
   end

   def load
    data = @brain.data[@user_id]
    return nil, nil unless data
    route = data[:route]
    return nil, nil unless route
    [route[:origin] || nil, route[:dest] || nil]
   end
  end
 end
end
