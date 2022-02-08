class Middleware::Error
  include JSON::Serializable
  property message : String
  getter :message

  @message = "Error was not provided a message"

  def initialize(@message)
  end
end
