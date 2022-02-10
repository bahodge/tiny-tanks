# TODO: Write documentation for `Backend`
require "kemal"
require "uuid"
require "json"
require "./user.cr"

class InvalidArgument < Exception
end

module Backend
  VERSION = "0.1.0"

  # Setup the users
  connected_users = [] of User

  before_all "/users/*" do |env|
    env.response.headers["Access-Control-Allow-Origin"] = "*"
    env.response.headers["Access-Control-Allow-Methods"] = "GET, PUT, POST, DELETE, OPTIONS"
    env.response.headers["Content-Type"] = "application/json"
    env.response.headers["Access-Control-Allow-Headers"] = "Access-Control-Allow-Headers, Origin,Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers"
  end

  # ################### USERS ############################
  get "/users" do |env|
    safe_users = connected_users.map do |user|
      user.to_safe
    end

    {data: safe_users}.to_json
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

    connected_users.push(user)
    Log.info { "User created - #{name}" }
    {data: user}.to_json
  end

  options "/users/create" do |env|
    env.response.headers["Access-Control-Allow-Methods"] = "POST, OPTIONS"
  end

  Kemal.run 4000
end
