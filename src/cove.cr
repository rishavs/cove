require "http/server"

require "./cove/*"

# TODO: Write documentation for `Cove`
module Cove

    server = HTTP::Server.new([
        HTTP::ErrorHandler.new,
        HTTP::LogHandler.new,
    ]) do |context|
        context.response.content_type = "text/plain"

    route = context.request.resource
    case route
        when "/hola"
            context.response.print "Yo buddy!"
        else
            context.response.print "Bewarsies! This be wasteland!"
        end
    end

    puts "Server Started! Listening on localhost:8080"
    server.listen(8080)
end
