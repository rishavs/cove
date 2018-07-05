require "http/server"
require "json"
require "dotenv"
require "db"
require "pg"
require "crypto/bcrypt/password"
require "uuid"
require "jwt"

require "./cove/actions/*"
require "./cove/views/*"
require "./cove/*"
require "./helpers/*"

module Cove
    Dotenv.load!
    DB     = PG.connect ENV["DATABASE_URL"]
    pp "Connecting to Database..."
    pp DB.scalar "SELECT 'Connection established! The DB sends its regards.'"

    server = HTTP::Server.new([
        HTTP::ErrorHandler.new,
        # HTTP::LogHandler.new,
        Cove::Logger.new,
    ]) do |context|
        context.response.content_type = "text/plain"

        route_url = context.request.resource
        route_method = context.request.method

        context.response.headers["Set-Cookie"] = "foo=bar; HttpOnly"
        # pp typeof(HTTP::Cookie.new("foo", "bar", "/admin", Time.now + 12.hours, secure: true))
        # context.response.headers["Set-Cookie"] = HTTP::Cookie.new("foo", "bar", "/admin", Time.now + 12.hours, secure: true)
        Router.run(route_method, route_url, context)
        
        # pp context
    end

    puts "Server Started! Listening on localhost:8080"
    server.listen(8080)
end
