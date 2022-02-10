require "json"
require "uuid/json"
require "./token.cr"

struct UserStruct
  include JSON::Serializable
  property name : String
  property id : UUID

  def initialize(@name : String, @id : UUID)
  end

  def to_json(json : JSON::Builder)
    json.object do
      json.field "id", @id.to_s
      json.field "name", @name
    end
  end
end

class User
  include JSON::Serializable
  getter :name, :token
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

  def to_struct
    UserStruct.new name: @name, id: @id
  end
end
