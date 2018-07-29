module Cove
    class Auth
        def self.check(ctx)
            if ctx.request.cookies.has_key?("usertoken") && ctx.request.cookies["usertoken"].value != "none"
                payload, header = JWT.decode(ctx.request.cookies["usertoken"].value, ENV["SECRET_JWT"], "HS256")
                { 
                    "loggedin" => "true", 
                    "unqid" => payload["unqid"].to_s, 
                    "email" => payload["email"].to_s,
                    "nickname" => payload["nickname"].to_s,
                    "flair" => payload["flair"].to_s,
                }
            else
                {"loggedin" => "none", "unqid" => "none", "email" => "none", "nickname" => "none", "flair" => "none" }
            end
        end

    end
end
