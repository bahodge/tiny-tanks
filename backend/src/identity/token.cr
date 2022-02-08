require "uuid"

class Identity::Token
  include JSON::Serializable

  property id : String
  property expires_at : Time

  getter :id, :expires_at

  def initialize(@user_id : String)
    @id = UUID.random.to_s
    @expires_at = Time.utc.shift days: 1
  end
end
