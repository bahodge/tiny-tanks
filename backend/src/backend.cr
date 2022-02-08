# TODO: Write documentation for `Backend`
require "kemal"
require "uuid"
require "json"
# require "./game/manager.cr"
require "./database.cr"
require "./user.cr"

module Backend
  VERSION = "0.1.0"

  # # Create the global game manager
  # game_manager = Game::Manager.new

  # Setup the database
  database = Database.new "tanks"
  database.create_collection "users", User

  before_all do |env|
    env.response.headers["Access-Control-Allow-Origin"] = "*"
    env.response.headers["Access-Control-Allow-Methods"] = "GET, PUT, POST, DELETE, OPTIONS"
    env.response.headers["Content-Type"] = "application/text"
    env.response.headers["Access-Control-Allow-Headers"] = "Access-Control-Allow-Headers, Origin,Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers"
  end

  # ################### USERS ############################

  get "/users" do |env|
    # collection = database.get "users"
    # if collection
    #   {data: collection.records}.to_json
    # end
  end

  # messages = [] of String
  # sockets = [] of HTTP::WebSocket

  # ws "/" do |socket|
  #   sockets.push socket

  #   # Handle incoming message and dispatch it to all connected clients
  #   socket.on_message do |message|
  #     messages.push message
  #     sockets.each do |a_socket|
  #       puts messages.to_json
  #       a_socket.send messages.to_json
  #     end
  #     messages.pop
  #   end

  #   # Handle disconnection and clean sockets
  #   socket.on_close do |_|
  #     sockets.delete(socket)
  #     puts "Closing Socket: #{socket}"
  #   end
  # end

  Kemal.run 4000
end
