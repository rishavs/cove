module Cove
    class Auth
        def self.register(ctx)

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
                {
                    "status" => "error", 
                    "message" => ex.message.to_s
                }
            else
                {
                    "status" => "success", 
                    "message" => "User was success fully added", 
                    "jsondata" => {"userid" => unqid, "username" => username}.to_json
                }
            end
        end

        def self.login(ctx)
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
                {
                    "status" => "error", 
                    "message" => ex.message.to_s
                }
            else
                token = Auth.get_jwt_if_match(username, password)
            end
        end

        # Created this separate function just so I can login regight after registering
        def self.get_jwt_if_match(username, password)
            begin
                user = DB.query_one "select unqid, username, password from users where username = $1", username, as: {unqid: String, username: String, password: String}
            rescue ex
                pp ex
                {
                    "status" => "error", 
                    "message" => "The user doesn't exists"
                }
            else
                if Crypto::Bcrypt::Password.new(user["password"].to_s) == password
                    puts "The password matches"
                    token = create_jwt(user["unqid"], user["username"])
                    {   
                        "status" => "success",
                        "message" => "Password was succesfully verified",
                        "data" => {
                            "unqid" => user["unqid"],
                            "username" => user["username"],
                            "token" => token
                        }
                    }
                else 
                    puts "The password DOESN'T matches"
                    {   
                        "status" => "error",
                        "message" => "The password is wrong",
                    }
                end
            end
        end
        def self.check?(ctx)
            if ctx.request.cookies.has_key?("usertoken")
                pp "Parsing token: " + ctx.request.cookies["usertoken"].value
                payload, header = JWT.decode(ctx.request.cookies["usertoken"].value, ENV["SECRET_JWT"], "HS256")
                { "loggedin" => true, "unqid" => payload["unqid"], "username" => payload["username"]}
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
