require "json"

class User
  include JSON::Serializable
  getter :name
  setter :name

  def initialize(@name : String)
  end

  def get_type
    Hash(String, Any)
  end

  def to_h
    {"name" => @name}
  end
end
