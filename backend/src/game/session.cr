# TODO - should have crud operations for players
# TODO - should
class Game::Session
  def initialize
    # Create a random id for this session
    @id = UUID.random

    # track the players within the game
  end

  def id
    @id
  end
end
