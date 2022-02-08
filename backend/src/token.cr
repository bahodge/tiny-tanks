require "json"
require "uuid/json"
require "base64"

class Token
  include JSON::Serializable
  property expires_at : Time

  def initialize(@owner_id : UUID)
    @id = UUID.random
    @expires_at = Time.utc.shift days: 1
  end

  def initialize(@owner_id : UUID)
    @id = UUID.random
    @expires_at = Time.utc.shift days: 1
  end

  def self.from_encoded(encoded_token : String)
    decoded = Base64.decode encoded_token
    p! typeof(decoded)
    p! decoded
  end

  def to_json(json : JSON::Builder)
    json.object do
      json.field "value", self.encode
    end
  end

  def self.decode(encoded_token : String)
    Base64.decode encoded_token
  end

  # Takes an encoded token
  def decode(encoded_token : String)
    Base64.decode encoded_token
  end

  def encode
    Base64.encode({"id" => @id, "expires_at" => @expires_at, "owner_id" => @owner_id}.to_s)
  end

  def is_valid?
    @expires_at > Time.utc
  end
end
