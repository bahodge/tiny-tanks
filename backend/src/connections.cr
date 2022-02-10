require "./user.cr"

class Connections
  property connections = [] of Connection

  def add_user(user : User)
    @connections.push Connection.new user
  end
end

struct Connection
  property :connected_at, :user

  def initialize(@user : User)
    @connected_at = Time.utc
  end
end
