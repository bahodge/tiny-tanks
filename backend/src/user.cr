require "json"
require "uuid/json"
require "./token.cr"

class User
  include JSON::Serializable
  getter :name, :token
  setter :name

  def initialize(@name : String)
    # Create a random ID for this user
    @id = UUID.random

    @token = Token.new @id
  end
end
