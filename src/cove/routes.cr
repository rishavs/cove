require "./views/**"

module Cove

    class Store 
        property status :       String = "none"
        property message :      String = "none"
        property currentuser :  Hash(String, String) = {"loggedin" => "none", "unqid" => "none", "nickname" => "none" }
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
            when {"about", "", "", "GET"}
                Cove::Misc.about(ctx)

                # Routes for errors
            when {"e", "401", "", "GET"}
                Cove::Errors.error401(ctx)

            # Routes for Posts resource
            when {"p", "new", "", "GET"}
                Cove::Posts.new_post(ctx)
 
            when {"p", "new", "", "POST"}
                Cove::Posts.create(ctx)

            when {"p", route.identifier, "", "GET"}
                Cove::Posts.read(ctx, route.identifier)
 
            when {"c", "new", "", "POST"}
                Cove::Comment.create(ctx)

            # Routes for Register resource
            when {"register", "", "", "GET"}
                Cove::Register.show(ctx)
            when {"register", "", "", "POST"}
                Cove::Register.adduser(ctx)

            # Routes for Login resource
            when {"login", "", "", "GET"}
                Cove::Login.show(ctx)
            when {"login", "", "", "POST"}
                Cove::Login.login(ctx)
            when {"logout","","", "GET"}
                Cove::Login.logout(ctx)

            # Catch-all routes    
            when {"", "", "", "GET"}
                Cove::Posts.list(ctx)
            else
                Cove::Errors.error404(ctx)
            end

        end

        def self.redirect(path, ctx)
            ctx.response.headers.add "Location", path
            ctx.response.status_code = 302
        end

    end
end