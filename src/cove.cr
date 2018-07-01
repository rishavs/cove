require "http/server"
require "json"
require "dotenv"
require "db"
require "pg"

require "./cove/actions/*"
require "./cove/views/*"
require "./cove/*"
require "./helpers/*"


# TODO: Write documentation for `Cove`
module Cove
    Dotenv.load!
    DB     = PG.connect ENV["DATABASE_URL"]
    puts "Initializing Database"


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
