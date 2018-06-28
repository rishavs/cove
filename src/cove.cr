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

        if !route_url.rstrip.ends_with?("/")
            route_url = route_url + "/"
        end

        case route_url
        when "/hola/"
            context.response.print "Yo buddy!"
        when "/json/"
            context.response.content_type = "application/json"
            json_string = JSON.build do |json|
                json.object do
                    json.field "name", "foo"
                    json.field "values" do
                        json.array do
                            json.number 1
                            json.number 2
                            json.number 3
                        end
                    end
                end
            end
                
            context.response.print json_string
        else
            context.response.print "Bewarsies! This be wasteland!"
        end
    end

    puts "Server Started! Listening on localhost:8080"
    server.listen(8080)
end
