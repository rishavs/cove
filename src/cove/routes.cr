require "./views/**"

module Cove
    class Router

        def self.run(method, url, ctx)
            url = clean(url)

            path = {url, method}

            case path
            when {"/hola/",     "GET"}
                ctx.response.print "Yo buddy!"
            when {"/about/",    "GET"}
                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.print Cove::Layout.render(Cove::Views.about)

            when {"/register/", "GET"}
                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.print Cove::Layout.render(Cove::Views.register)
            when {"/register/", "POST"}
                ctx.response.content_type = "text/html; charset=utf-8"   
                store = Cove::Auth.register(ctx)
                ctx.response.print store
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