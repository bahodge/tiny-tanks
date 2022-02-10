# TODO: Write documentation for `Backend`
require "kemal"
require "uuid"
require "json"

require "./user.cr"
require "./connections.cr"
require "./database.cr"

class InvalidArgument < Exception
end

module Backend
  VERSION = "0.1.0"

  database = Database.new
  database.create_collection "users"

  before_all "/users/*" do |env|
    env.response.headers["Access-Control-Allow-Origin"] = "*"
    env.response.headers["Access-Control-Allow-Methods"] = "GET, PUT, POST, DELETE, OPTIONS"
    env.response.headers["Content-Type"] = "application/json"
    env.response.headers["Access-Control-Allow-Headers"] = "Access-Control-Allow-Headers, Origin,Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers"
  end

  # ################### USERS ############################
  options "/users/create" do |env|
    env.response.headers["Access-Control-Allow-Methods"] = "POST, OPTIONS"
  end

  post "/users/create" do |env|
    unless env.params.json.has_key? "name"
      halt env, status_code: 400, response: "Bad Request `name` is required"
    end

    if env.params.json["name"].as(String).empty?
      halt env, status_code: 400, response: "Bad Request `name` is required"
    end
    name = env.params.json["name"].as(String)
    user = User.new name

    database.collections["users"].insert(id: user.id, record: user.to_json)

    json = database.collections["users"].find_by(id: user.id)
    p! "#{json}"
    p! "#{User.from_json json}"

    Log.info { "User created - #{name}" }
    {data: user}.to_json
  end

  # ################## LOGIN ########################
  post "/login" do |env|
  end

  Kemal.run 4000
end
