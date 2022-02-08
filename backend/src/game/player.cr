class Game::Player
  getter :name, :id
  setter :name

  @name = "default name"

  def initialize(@name : String)
    @id = UUID.random
  end

  def to_json
    {"id" => @id.to_s, "name" => @name}.to_json
  end
end
