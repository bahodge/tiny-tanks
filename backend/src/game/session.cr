# TODO - should have crud operations for players
# TODO - should
require "json"
require "./player.cr"

class Game::Session
  getter :id, :players, :leader

  def initialize
    # Create a random id for this session
    @id = UUID.random

    # track the players within the session
    @players = [] of Game::Player
  end

  def leader
    if @leader.nil?
      # The first player (game creator is the leader)
      @leader = @players[0]
      @leader
    else
      @leader
    end
  end

  def to_json
    {"id" => @id.to_s, "players" => @players.map &.to_json}.to_json
  end
end
