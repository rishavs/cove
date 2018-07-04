require "http/server"
require "json"
require "dotenv"
require "db"
require "pg"
require "crypto/bcrypt/password"
require "uuid"

require "./cove/actions/*"
require "./cove/views/*"
require "./cove/*"
require "./helpers/*"

module Cove
    Dotenv.load!
    DB     = PG.connect ENV["DATABASE_URL"]
    pp "Connecting to Database..."
    test_db = DB.scalar "SELECT 'Connection established! The DB sends its regards.'"
    pp test_db

    server = HTTP::Server.new([
        HTTP::ErrorHandler.new,
        # HTTP::LogHandler.new,
        Cove::Logger.new,
    ]) do |context|
        context.response.content_type = "text/plain"

        route_url = context.request.resource
        route_method = context.request.method

        Router.run(route_method, route_url, context)

    end

    puts "Server Started! Listening on localhost:8080"
    server.listen(8080)
end
