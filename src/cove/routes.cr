require "./views/**"

module Cove
    class Store
        property status = "none" 
        property message = "none"
        property data = "none"
    end

    class Router



        def self.run(method, url, ctx)

            store = Cove::Store.new

            url = clean(url)
            path = {url, method}

            case path
            when {"/hola/",     "GET"}
                ctx.response.print "Yo buddy!"
            when {"/about/",    "GET"}
                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.print Cove::Layout.render(Cove::Views.about)
            
            # Routes for Register resource
            when {"/register/", "GET"}
                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.print Cove::Layout.render(Cove::Views.register)
            when {"/register/", "POST"}
                ctx.response.content_type = "text/html; charset=utf-8"   
                payload = Cove::Auth.register(ctx)
                # ctx.response.print payload

            # Catch-all routes    
            when {"/", "GET"}
                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.print Cove::Layout.render(Cove::Views.home)
            else
                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.print Cove::Layout.render("404! Bewarsies! This be wasteland!")
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