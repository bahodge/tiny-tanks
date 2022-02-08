require "./user.cr"
require "./token.cr"

class Identity::Manager
  getter :users

  def initialize
    @users = [] of Identity::User
  end

  # This is a new identity we haven't seen before
  def create_user
    @users.push(Identity::User.new)
  end
end
