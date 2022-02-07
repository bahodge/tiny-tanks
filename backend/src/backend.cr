# TODO: Write documentation for `Backend`
require "kemal"
require "uuid"
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

  before_all "/game_session" do |env|
    env.response.content_type = "application/json"
  end

  post "/game_session" do |env|
    puts "env #{env.response.headers}"
    session = game_manager.create_session

    {"data" => "Session created #{session.id}"}.to_json
  end

  delete "/game_session" do |env|
    puts "env #{env.response.headers}"

    {"data" => "Session closed!"}.to_json
  end

  options "/game_session" do |env|
    env.response.headers["Content-Type"] = "application/text"
    "GET, PUT, POST, DELETE, OPTIONS"
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
