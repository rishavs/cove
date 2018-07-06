module Cove
    class Auth
        def self.register(ctx)

            store = Cove::Store.new

            begin
                params =    Cove::Parse.form_params(ctx.request.body)
                username =  params.fetch("username")
                password =  params.fetch("password")
                
                # Trim leading & trailing whitespace
                username = username.downcase.lstrip.rstrip

                # Validation checks
                Cove::Validate.if_length(username, "username", 3, 32)
                Cove::Validate.if_length(password, "password", 3, 32)
                Cove::Validate.if_unique(username, "username", "users")

                # Generate some data
                unqid = UUID.random.to_s
                password = Crypto::Bcrypt::Password.create(password).to_s
                
                # DB operations
                Cove::DB.exec "insert into users values ($1, $2, $3)", unqid, username, password

            rescue ex
                pp ex
                store.status = "error"
                store.message = ex.message.to_s
                store.data = {"none" => "none"}

                store
            else
                store.status = "success"
                store.message = "User was success fully added"
                store.data = {"userid" => unqid, "username" => username}

                store
            end
        end

        def self.login(ctx)

            store = Cove::Store.new

            begin
                params =    Cove::Parse.form_params(ctx.request.body)
                username =  params.fetch("username")
                password =  params.fetch("password")
                
                # Trim leading & trailing whitespace
                username = username.downcase.lstrip.rstrip

                # Validation checks
                Cove::Validate.if_length(username, "username", 3, 32)
                Cove::Validate.if_length(password, "password", 3, 32)

            rescue ex
                pp ex
                store.status = "error"
                store.message = ex.message.to_s
                store.data = {"none" => "none"}

                store
            else
                Auth.get_jwt_if_match(username, password)
            end
        end

        # Created this separate function just so I can login regight after registering
        def self.get_jwt_if_match(username, password)
            
            store = Cove::Store.new

            begin
                user = DB.query_one "select unqid, username, password from users where username = $1", username, as: {unqid: String, username: String, password: String}
            rescue ex
                pp ex
                store.status = "error"
                store.message = "The user doesn't exists"
                store.data = {"none" => "none"}

                store
            else
                if Crypto::Bcrypt::Password.new(user["password"].to_s) == password
                    puts "The password matches"
                    token = create_jwt(user["unqid"], user["username"])
                    
                    store.status = "success"
                    store.message = "Password was succesfully verified"
                    store.data = {
                        "unqid" => user["unqid"],
                        "username" => user["username"],
                        "token" => token.to_s
                    }

                    store
                else 
                    puts "The password DOESN'T matches"
                    store.status = "error"
                    store.message = "The password is wrong"
                    store.data = {"none" => "none"}

                    store
                end
            end
        end
        def self.check(ctx)
            if ctx.request.cookies.has_key?("usertoken")

                payload, header = JWT.decode(ctx.request.cookies["usertoken"].value, ENV["SECRET_JWT"], "HS256")
                { "loggedin" => "true", "unqid" => payload["unqid"].to_s, "username" => payload["username"].to_s}
            else
                {"loggedin" => "none", "unqid" => "none", "username" => "none" }
            end
        end
        def self.guard (env)

        end

        def self.create_jwt (uid, uname)
            exp = Time.now.epoch + 6000000
            payload = { "unqid" => uid, "username" => uname, "exp" => exp }
            JWT.encode(payload, ENV["SECRET_JWT"], "HS256")
        end
    end
end
