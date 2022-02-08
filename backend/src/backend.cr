# TODO: Write documentation for `Backend`
require "kemal"
require "uuid"
require "json"
require "./game/manager.cr"

module Backend
  INTERVAL = 10_000
  VERSION  = "0.1.0"

  # Create the global game manager
  game_manager = Game::Manager.new

  before_all do |env|
    env.response.headers["Access-Control-Allow-Origin"] = "*"
    env.response.headers["Access-Control-Allow-Methods"] = "GET, PUT, POST, DELETE, OPTIONS"
  end

  before_all "/*" do |env|
    env.response.content_type = "application/json"
  end

  options "/game_session/*" do |env|
    env.response.headers["Content-Type"] = "application/text"
    env.response.headers["Access-Control-Allow-Headers"] = "Access-Control-Allow-Headers, Origin,Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers"
    env.response.headers["Access-Control-Allow-Methods"] = "GET, PUT, POST, DELETE, OPTIONS"
  end

  post "/game_session/create" do |env|
    puts "post /game_session/create"
    session = game_manager.create_session

    {"data" => "Session created #{session.id}"}.to_json
  end

  post "/game_session/join" do |env|
    name = env.params.json["name"].as(String)
    id = env.params.json["id"].as(String)

    session = game_manager.sessions.find { |session| session.id == id }

    if session.nil?
      {error: "Session with `#{id}` not found"}.to_json
    else
      session.add_player(name)
      {data: "Joined session: #{session.id}"}.to_json
    end
  end

  delete "/game_session/delete" do |env|
    puts "delete /game_session/delete"

    {"data" => "Session closed!"}.to_json
  end

  get "/game_session" do |env|
    puts "get /game_session"

    unless env.params.query["id"]
      {"error" => "Expected `id` query param"}.to_json
    else
      id : String = env.params.query["id"]
      session = game_manager.sessions.find { |session| session.id == id }

      if session.nil?
        {"error" => "Session with `#{id}` not found"}.to_json
      else
        {"data" => session}.to_json
      end
    end
  end

  get "/game_sessions" do |env|
    puts "get /game_sessions"

    puts "response #{{data: game_manager.sessions}.to_json}"
    {data: game_manager.sessions}.to_json
  end

  messages = [] of String
  sockets = [] of HTTP::WebSocket

  ws "/" do |socket|
    sockets.push socket

    # Handle incoming message and dispatch it to all connected clients
    socket.on_message do |message|
      messages.push message
      sockets.each do |a_socket|
        puts messages.to_json
        a_socket.send messages.to_json
      end
      messages.pop
    end

    # Handle disconnection and clean sockets
    socket.on_close do |_|
      sockets.delete(socket)
      puts "Closing Socket: #{socket}"
    end
  end

  Kemal.run 4000
end
