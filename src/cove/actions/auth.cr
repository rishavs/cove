module Cove
    class Auth
        def self.register(ctx)
            params =    Cove::Parse.form_params(ctx.request.body)
            username =  params.fetch("username")
            password =  params.fetch("password")

            store = {
                "status" => "success", 
                "message" => "User was success fully added", 
                "data" => {"userid" => "xxx", "username" => username}
            }
        end
    end
end
