require "./views/**"

module Cove

    class Store 
        property status :       String = "none"
        property message :      String = "none"
        property currentuser :  Hash(String, String) = {"loggedin" => "none", "unqid" => "none", "username" => "none" }
    end
    class Route 
        property resource :     String = ""
        property identifier :   String = ""
        property verb :         String = ""
        
        def initialize(url : String)
            # Remove all leading and trailing whitespaces.
            url = url.lstrip("/").rstrip(" / ")
            arr = url.split("/")

            @resource =     arr[0]? ? arr[0] : ""
            @identifier =   arr[1]? ? arr[1] : ""
            @verb =         arr[2]? ? arr[2] : ""

        end
    end

    class Router
        def self.run(method, url, ctx)
            store = Cove::Store.new
            route = Route.new(url)

            case {route.resource, route.identifier, route.verb, method}
            # when {"about", "", "", "GET"}
            #     ctx.response.content_type = "text/html; charset=utf-8"    
            #     ctx.response.print Cove::Layout.render(Cove::Views.about(store), store)
            # when {"noanon", "", "", "GET"}
            #     guard("anon", store.currentuser["loggedin"], ctx)
            #     ctx.response.content_type = "text/html; charset=utf-8"    
            #     ctx.response.print "Yo"
            # when {"nologgy", "", "", "GET"}
            #     guard("user", store.currentuser["loggedin"], ctx)
            #     ctx.response.content_type = "text/html; charset=utf-8"    
            #     ctx.response.print "Yo"
            # when {"secret", "", "", "GET"}
            #     if store.currentuser["loggedin"] == "true"
            #         ctx.response.print "Yo #{ store.currentuser["username"] }! This secret is yours!"
            #     else
            #         ctx.response.print "Sorry anon. This secret isn't meant for you!"
            #     end

            #     # Routes for Posts resource
            # when {"p", "new", "", "GET"}
            #     guard("anon", store.currentuser["loggedin"], ctx)
            #     ctx.response.content_type = "text/html; charset=utf-8"    
            #     ctx.response.print Cove::Layout.render(Cove::Views.new_post(store), store)
            # when {"p", "new", "", "POST"}
            #     guard("anon", store.currentuser["loggedin"], ctx)
            #     ctx.response.content_type = "text/html; charset=utf-8"   
            #     payload = Cove::Posts.create(ctx, store.currentuser["unqid"])
            #     store.status =      payload.status
            #     store.message =     payload.message
            #     store.data =        payload.data
            #     if  store.status == "error"
            #         ctx.response.print Cove::Layout.render(Cove::Views.new_post(store), store)
            #     else
            #         ctx.response.print store
            #     end                
            # when {"p", route.identifier, "", "GET"}
            #     ctx.response.content_type = "text/html; charset=utf-8"  
            #     payload = Cove::Posts.read(ctx, route.identifier)
            #     store.status =      payload.status
            #     store.message =     payload.message
            #     store.data =        payload.data
            #     if  store.status == "error"
            #         ctx.response.print Cove::Layout.render(Cove::Views.home(store), store)
            #     else
            #         ctx.response.print Cove::Layout.render(Cove::Views.read_post(store), store)
            #     end
            # # when {"post", route.identifier, "edit", "GET"}
            # # when {"post", route.identifier, "", "GET"}
            # # when {"/about/", "", "", "GET"}
                            
            # # Routes for Register resource
            # when {"register", "", "", "GET"}
            #     ctx.response.content_type = "text/html; charset=utf-8"    
            #     ctx.response.print Cove::Layout.render(Cove::Views.register(store), store)
            # when {"register", "", "", "POST"}
            #     ctx.response.content_type = "text/html; charset=utf-8"   
            #     payload = Cove::Auth.register(ctx)
            #     store.status =      payload.status
            #     store.message =     payload.message
            #     store.data =        payload.data
            #     if  store.status == "error"
            #         ctx.response.print Cove::Layout.render(Cove::Views.register(store), store)
            #     else
            #         ctx.response.print store
            #     end

            # # Routes for Login resource
            # when {"login", "", "", "GET"}
            #     ctx.response.content_type = "text/html; charset=utf-8"    
            #     ctx.response.print Cove::Layout.render(Cove::Views.login(store), store)
            # when {"login", "", "", "POST"}
            #     ctx.response.content_type = "text/html; charset=utf-8"   
            #     payload =  Cove::Auth.login(ctx)
            #     store.status =      payload.status
            #     store.message =     payload.message
            #     store.data =        payload.data
            #     if store.status == "error"
            #         ctx.response.print Cove::Layout.render(Cove::Views.login(store), store)
            #     else
            #         usercookie = HTTP::Cookie.new("usertoken", store.data["token"], "/", Time.now + 12.hours)
            #         ctx.response.headers["Set-Cookie"] = usercookie.to_set_cookie_header
            #         redirect("/", ctx)
            #     end
            # when {"logout","","", "GET"}
            #     usercookie = HTTP::Cookie.new("usertoken", "none", "/", Time.now + 12.hours)
            #     ctx.response.headers["Set-Cookie"] = usercookie.to_set_cookie_header
            #     redirect("/", ctx)

            # Catch-all routes    
            when {"", "", "", "GET"}
                Cove::Posts.list(ctx)
            else
                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.status_code = 404
                ctx.response.print Cove::Layout.render(store, "404! Bewarsies! This be wasteland!")
            end

        end

        def self.guard ( against, isloggedin, ctx)
            if against == "user" && isloggedin == "true"
                redirect("/", ctx)
            elsif against == "anon" && isloggedin != "true"
                redirect("/", ctx)
            end
        end

        def self.redirect(path, ctx)
            ctx.response.headers.add "Location", path
            ctx.response.status_code = 302
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