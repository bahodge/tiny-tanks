require "json"
require "uuid/json"
require "base64"

class Token
  include JSON::Serializable

  @[JSON::Field(key: "id")]
  property id : UUID

  # When this is called through from_json
  # It rounds the time to the second, and does not carry
  # over the smaller time measurements
  @[JSON::Field(key: "expires_at")]
  property expires_at : Time

  getter :id, :expires_at

  def initialize(@id = UUID.random,
                 @expires_at = Time.utc.shift days: 1)
  end

  def to_json(json : JSON::Builder)
    json.object do
      json.field "id", @id.to_s
      json.field "expires_at", @expires_at
    end
  end

  def self.decode(encoded_token : String)
    Base64.decode_string encoded_token
  end

  # Takes an encoded token
  def decode(encoded_token : String)
    Base64.decode_string encoded_token
  end

  def encode
    Base64.strict_encode(self.to_json)
  end

  def is_valid?
    @expires_at > Time.utc
  end

  def self.from_encoded(encoded : String)
    json = Base64.decode_string encoded

    Token.from_json json
  end
end
