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
            when "/html/"
                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.print Cove::Views::Layout.render
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
end