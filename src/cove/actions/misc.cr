module Cove
    class Misc
        def self.about(ctx)
            store = Cove::Store.new

            ctx.response.content_type = "text/html; charset=utf-8"    
            ctx.response.print Cove::Layout.render( store, Cove::Views.about)
        end
    end
end
