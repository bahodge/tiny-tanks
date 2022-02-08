require "json"
require "./player.cr"

class Game::Session
  include JSON::Serializable
  property id : String
  property players : Array(Game::Player)

  getter :id, :players

  def initialize
    @id = UUID.random.to_s

    @players = [] of Game::Player
  end

  def leader
    @players.find &.is_leader?
  end

  def elect_leader
    current_leader = self.leader

    if current_leader.nil?
      @players[0].elect # elect the first player who joined
    end
    current_leader
  end

  def add_player(name : String)
    @players.push(Game::Player.new(name: name))

    if self.leader.nil?
      self.elect_leader
    end
  end
end
