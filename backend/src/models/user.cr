require "json"

class User
  include JSON::Serializable

  property name : String = "Default Name"

  getter :name
  setter :name

  def initialize(@name)
  end
end
