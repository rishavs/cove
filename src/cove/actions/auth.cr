module Cove
    class Auth
        def self.register(ctx)

            begin
                params =    Cove::Parse.form_params(ctx.request.body)
                username =  params.fetch("username")
                password =  params.fetch("password")
                
                # Validation checks
                Cove::Validate.if_length(username, "username", 3, 32)
                # Cove::Validate.if_unique(username, users)

                # Transform some data
                unqid = UUID.random.to_s
                password = Crypto::Bcrypt::Password.create(password).to_s
                
                # DB operations
                db.exec "insert into users values ($1, $2, $3)", unqid, username, password


            # rescue Cove::ValidationError
            #     pp "Raised ValidationError"

            #     store = {
            #         "status" => "error", 
            #         "message" => ex.message.to_s
            #     }
            rescue ex
                pp ex
                store = {
                    "status" => "error", 
                    "message" => ex.message.to_s
                }
            else
                store = {
                    "status" => "success", 
                    "message" => "User was success fully added", 
                    "data" => {"userid" => unqid, "username" => username}
                }
            end



        end
    end
end
