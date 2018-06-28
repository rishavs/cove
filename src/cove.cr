require "http/server"

require "./cove/*"

# TODO: Write documentation for `Cove`
module Cove

    server = HTTP::Server.new([
        HTTP::ErrorHandler.new,
        HTTP::LogHandler.new,
    ]) do |context|
        context.response.content_type = "text/plain"
        context.response.print "Hello world!"
    end

    server.listen(8080)
end
