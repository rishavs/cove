require "http/server"
require "json"

require "./cove/*"

# TODO: Write documentation for `Cove`
module Cove
    class Router
        def self.run(method, url, ctx)
            url = clean(url)
            case url
            when "/hola/"
                ctx.response.print "Yo buddy!"
            when "/json/"
                ctx.response.content_type = "application/json"
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
                    
                ctx.response.print json_string
            else
                ctx.response.print "Bewarsies! This be wasteland!"
            end
        end

        def self.clean (url)
            if !url.rstrip.ends_with?("/")
                url + "/"
            else
                url
            end
        end
    end

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
