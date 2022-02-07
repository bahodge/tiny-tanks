require "./session.cr"

class Game::Manager
  def initialize
    @sessions = [] of Game::Session

    # puts "Game Created: #{@session.id}"
  end

  def create_session
    session = Game::Session.new
    @sessions.push(session)
    session
  end

  def close_session
    @sessons.each { |session| puts session.id }
  end

  # def session
  #   @session
  # end
end
