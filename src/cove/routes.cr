require "./views/**"

module Cove

    class Store 
        property status :       String = "none"
        property message :      String = "none"
        property data :         Hash(String, String) = {"none" => "none"}
        property currentuser :  Hash(String, String) = {"loggedin" => "none", "unqid" => "none", "username" => "none" }
    end

    class Router
        def self.run(method, url, ctx)
            url = clean(url)
            path = {url, method}
            store = Store.new
            store.currentuser = Cove::Auth.check(ctx)

            case path
            when {"/about/",    "GET"}
                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.print Cove::Layout.render(Cove::Views.about(store), store)
            when {"/noanon/",    "GET"}
                guard("anon", store.currentuser["loggedin"], ctx)
                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.print "Yo"
            when {"/nologgy/",    "GET"}
                guard("user", store.currentuser["loggedin"], ctx)
                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.print "Yo"
            when {"/secret/",     "GET"}
                if store.currentuser["loggedin"] == "true"
                    ctx.response.print "Yo #{ store.currentuser["username"] }! This secret is yours!"
                else
                    ctx.response.print "Sorry anon. This secret isn't meant for you!"
                end

            # Routes for Register resource
            when {"/register/", "GET"}
                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.print Cove::Layout.render(Cove::Views.register(store), store)
            when {"/register/", "POST"}
                ctx.response.content_type = "text/html; charset=utf-8"   
                payload = Cove::Auth.register(ctx)
                store.status =      payload.status
                store.message =     payload.message
                store.data =        payload.data
                if  store.status == "error"
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
                payload =  Cove::Auth.login(ctx)
                store.status =      payload.status
                store.message =     payload.message
                store.data =        payload.data
                if store.status == "error"
                    ctx.response.print Cove::Layout.render(Cove::Views.login(store), store)
                else
                    usercookie = HTTP::Cookie.new("usertoken", store.data["token"], "/", Time.now + 12.hours)
                    ctx.response.headers["Set-Cookie"] = usercookie.to_set_cookie_header
                    redirect("/", ctx)
                end
            when {"/logout/", "GET"}
                usercookie = HTTP::Cookie.new("usertoken", "none", "/", Time.now + 12.hours)
                ctx.response.headers["Set-Cookie"] = usercookie.to_set_cookie_header
                redirect("/", ctx)

            # Catch-all routes    
            when {"/", "GET"}
                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.print Cove::Layout.render(Cove::Views.home(store), store)
            else
                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.print Cove::Layout.render("404! Bewarsies! This be wasteland!", store)
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