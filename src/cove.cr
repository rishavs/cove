require "http/server"
require "json"

require "./cove/*"

# TODO: Write documentation for `Cove`
module Cove

    
    server = HTTP::Server.new([
        HTTP::ErrorHandler.new,
        HTTP::LogHandler.new,
    ]) do |context|
        context.response.content_type = "text/plain"

        route_url = context.request.resource
        route_method = context.request.method

        Router.run(route_method, route_url, context)

    end

    puts "Server Started! Listening on localhost:8080"
    server.listen(8080)
end
