require "http/server"
require "json"
require "dotenv"
require "db"
require "pg"
require "crypto/bcrypt/password"
require "uuid"
require "jwt"
require "option_parser"

require "./cove/actions/*"
require "./cove/views/*"
require "./cove/*"
require "./helpers/*"

module Cove
    port = 4321

    if !ENV.has_key?("DEV")
        Dotenv.load
        port = ENV["PORT"].to_i
    else
        OptionParser.parse! do |opts|
            opts.on("-p PORT", "--port PORT", "define port to run server") do |opt|
                port = opt.to_i
            end
        end
    end

    DB = PG.connect ENV["DATABASE_URL"]

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

        Router.run(route_method, route_url, context)
        
        # pp context
    end

    puts "Server Started! Listening on localhost:#{port}"
    server.listen(port)
end
