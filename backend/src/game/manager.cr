require "./session.cr"

class Game::Manager
  getter :sessions

  def initialize
    @sessions = [] of Game::Session
  end

  def create_session
    session = Game::Session.new
    @sessions.push(session)
    session
  end

  def close_session(session_id : UUID)
    @sessons.delete { |session| session_id == session.id }
  end
end
