module Cove
    class Auth
        def self.register(ctx)
            store = {
                "status" => "error", 
                "message" => "Unhandled Error"
            }

            params =    Cove::Parse.form_params(ctx.request.body)
            username =  params.fetch("username")
            password =  params.fetch("password")

            if (Cove::Validate.if_unique(username, users) &&
                Cove::Validate.if_length(username, 3, 32))

            end
            store = {
                "status" => "success", 
                "message" => "User was success fully added", 
                "data" => {"userid" => "xxx", "username" => username}
            }
        end
    end
end
