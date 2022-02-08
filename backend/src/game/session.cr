# TODO - should have crud operations for players
# TODO - should
require "json"
require "./player.cr"

class Game::Session
  include JSON::Serializable
  property id : String
  # property players : [] of Game::Player
  # property leader : Game::Player

  getter :id

  def initialize
    # Create a random id for this session
    @id = UUID.random.to_s

    # track the players within the session
    # @players = [] of Game::Player
  end

  def serialize_id
    @id.to_s
  end

  # def leader
  #   if @leader.nil?
  #     # The first player (game creator is the leader)
  #     @leader = @players[0]
  #     @leader
  #   else
  #     @leader
  #   end
  # end
end
