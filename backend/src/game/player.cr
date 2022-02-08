class Game::Player
  include JSON::Serializable

  property id : String

  getter :name, :id, :is_leader
  setter :name

  @name = "default name"

  def initialize(@name : String)
    @id = UUID.random.to_s
    @is_leader = false
  end

  def elect
    @is_leader = true
    self
  end

  def is_leader?
    @is_leader
  end
end
