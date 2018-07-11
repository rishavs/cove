module Cove
    class Login
        def self.show(ctx)
            store = Cove::Store.new
            store.currentuser = Cove::Auth.check(ctx)

            ctx.response.content_type = "text/html; charset=utf-8"    
            ctx.response.print Cove::Layout.render( store, Cove::Views.login)
        end

        def self.login(ctx)
            store = Cove::Store.new
            store.currentuser = Cove::Auth.check(ctx)

            begin
                params =    Cove::Parse.form_params(ctx.request.body)
                username =  params.fetch("username")
                password =  params.fetch("password")
                
                # Trim leading & trailing whitespace
                username = username.downcase.lstrip.rstrip

                # Validation checks
                Cove::Validate.if_length(username, "username", 3, 32)
                Cove::Validate.if_length(password, "password", 3, 32)

                user = DB.query_one "select unqid, username, password from users where username = $1", username, as: {unqid: String, username: String, password: String}
            
            rescue ex
                pp ex
                store.status = "error"
                if ex.message.to_s == "no rows"
                    store.message = "The User does not exists"
                else
                    store.message = ex.message.to_s
                end

                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.print Cove::Layout.render( store, Cove::Views.login)
            else
                if Crypto::Bcrypt::Password.new(user["password"].to_s) == password
                    puts "The password matches"

                    exp = Time.now.epoch + 6000000
                    payload = { "unqid" => user["unqid"], "username" => user["username"], "exp" => exp }
                    token = JWT.encode(payload, ENV["SECRET_JWT"], "HS256")
                    # token = create_jwt(user["unqid"], user["username"])
                    usercookie = HTTP::Cookie.new("usertoken", token, "/", Time.now + 12.hours)
                    ctx.response.headers["Set-Cookie"] = usercookie.to_set_cookie_header
    
                    store.status = "success"
                    store.message = "User was success logged in"
                    Cove::Router.redirect("/", ctx)
                else 
                    puts "The password DOESN'T matches"
                    store.status = "error"
                    store.message = "The password is wrong"
                    
                    ctx.response.content_type = "text/html; charset=utf-8"    
                    ctx.response.print Cove::Layout.render( store, Cove::Views.login)
                end
            end
        end
        def self.logout(ctx)
            usercookie = HTTP::Cookie.new("usertoken", "none", "/", Time.now + 12.hours)
            ctx.response.headers["Set-Cookie"] = usercookie.to_set_cookie_header
            Cove::Router.redirect("/", ctx)
        end
    end
end
