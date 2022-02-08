require "uuid"
require "./token.cr"

class Identity::User
  include JSON::Serializable

  property id : String

  getter :id

  def initialize
    # make a new identity
    @id = UUID.random.to_s
    @token = Identity::Token.new user_id: @id
  end
end
