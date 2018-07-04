require "./views/**"

module Cove

    class Router
        def self.run(method, url, ctx)
            url = clean(url)
            path = {url, method}
            store = {
                "status" => "none", 
                "message" => "none"
            }

            case path
            when {"/hola/",     "GET"}
                ctx.response.print "Yo buddy!"
            when {"/about/",    "GET"}
                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.print Cove::Layout.render(Cove::Views.about(store), store)
            
            # Routes for Register resource
            when {"/register/", "GET"}
                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.print Cove::Layout.render(Cove::Views.register(store), store)
            when {"/register/", "POST"}
                ctx.response.content_type = "text/html; charset=utf-8"   
                store = Cove::Auth.register(ctx)
                if store["status"] == "error"
                    ctx.response.print Cove::Layout.render(Cove::Views.register(store), store)
                else
                    ctx.response.print store
                end

            # Routes for Login resource
            when {"/login/", "GET"}
                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.print Cove::Layout.render(Cove::Views.login(store), store)
            when {"/login/", "POST"}
                ctx.response.content_type = "text/html; charset=utf-8"   
                store = Cove::Auth.login_form(ctx)
                ctx.response.print store

            # Catch-all routes    
            when {"/", "GET"}
                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.print Cove::Layout.render(Cove::Views.home(store), store)
            else
                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.print Cove::Layout.render("404! Bewarsies! This be wasteland!", store)
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