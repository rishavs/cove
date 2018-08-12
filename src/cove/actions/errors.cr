module Cove
    class Errors
        def self.error404(ctx)
            store = Cove::Store.new
            store.status = "error"
            store.message = "You got 404ed"
            store.currentuser = Cove::Auth.check(ctx)

            ctx.response.content_type = "text/html; charset=utf-8"    
            ctx.response.status_code = 404
            ctx.response.print Cove::Layout.render(store, Cove::Views.error404)
        end
        def self.error401(ctx)
            store = Cove::Store.new
            store.status = "error"
            store.message = "You got 401ed"
            store.currentuser = Cove::Auth.check(ctx)

            ctx.response.content_type = "text/html; charset=utf-8"    
            ctx.response.status_code = 401
            ctx.response.print Cove::Layout.render(store, Cove::Views.error401)
        end

    end
end
