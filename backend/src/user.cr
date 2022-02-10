require "json"
require "uuid/json"
require "./token.cr"

class User
  include JSON::Serializable
  getter :name, :id, :token
  setter :name

  def initialize(@name : String = "Default Name")
    # Create a random ID for this user
    @id = UUID.random
    @token = Token.new user_id: @id
  end

  def to_json(json : JSON::Builder)
    json.object do
      json.field "id", @id.to_s
      json.field "name", @name
      json.field "token", @token.encode
    end
  end

  def to_safe
    UserSafe.new @id, @name
  end
end

class UserSafe
  getter :name, :id

  def initialize(@id : UUID, @name : String)
  end

  def to_json(json : JSON::Builder)
    json.object do
      json.field "id", @id.to_s
      json.field "name", @name
    end
  end
end
