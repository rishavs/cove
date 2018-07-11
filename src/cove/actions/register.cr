module Cove
    class Register
        def self.show(ctx)
            store = Cove::Store.new
            store.currentuser = Cove::Auth.check(ctx)

            ctx.response.content_type = "text/html; charset=utf-8"    
            ctx.response.print Cove::Layout.render( store, Cove::Views.register)
        end

        def self.adduser(ctx)
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

                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.print Cove::Layout.render( store, Cove::Views.register)
            else
                store.status = "success"
                store.message = "User was success fully added"
                Cove::Router.redirect("/", ctx)
            end
        end
    end
end
