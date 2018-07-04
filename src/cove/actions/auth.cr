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

        def self.login_form(ctx)
            begin
                params =    Cove::Parse.form_params(ctx.request.body)
                username =  params.fetch("username")
                password =  params.fetch("password")
                
                # Trim leading & trailing whitespace
                username = username.downcase.lstrip.rstrip

                # Validation checks
                Cove::Validate.if_exists(username, "username", "users")

                token = Auth.login(username, password)
            rescue ex
                pp ex
                {
                    "status" => "error", 
                    "message" => ex.message.to_s
                }
            else
                {   
                    "status" => "success",
                    "message" => "Password was succesfully verified",
                    "data" => token
                }
            end
        end

        def self.login(username, password)
            password_hash = DB.scalar "select password from users where username = $1 LIMIT 1", username
            if Crypto::Bcrypt::Password.new(password_hash.to_s) == password
                puts "The password matches"
                # token = generate_jwt_token(user.unqid, user.username)
            else 
                
                puts "The password DOESN'T matches"
            end

        end
    end
end
