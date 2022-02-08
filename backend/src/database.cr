require "./models/user.cr"
require "./collection.cr"

class Database
  property users : Collection

  getter :users

  def initialize
  end
end
