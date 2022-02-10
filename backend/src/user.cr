require "json"
require "uuid/json"
require "./token.cr"

class User
  include JSON::Serializable
  @[JSON::Field(key: "id")]
  property id : UUID

  @[JSON::Field(key: "token", converter: Token.from_encoded)]
  property token : Token

  @[JSON::Field(key: "name")]
  property name : String

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
end
