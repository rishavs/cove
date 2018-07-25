module Cove
    class Comment

        def self.create(ctx, post_id)
            store = Cove::Store.new
            store.currentuser = Cove::Auth.check(ctx)
            pp

            begin
                params =    Cove::Parse.form_params(ctx.request.body)
                Cove::Validate.if_loggedin(store.currentuser)
                
                parent_id =  "none"
                level = 0
                content = params.fetch("post_reply_field")
                author_id = store.currentuser["unqid"]
                
                # Trim leading & trailing whitespace
                content = content.lstrip.rstrip

                # Validation checks
                Cove::Validate.if_length(content, "content", 3, 2048)

                # Generate some data
                unqid = UUID.random.to_s
                
                # DB operations
                Cove::DB.exec "insert into comments (unqid, level, parent_id, post_id, content, author_id) values ($1, $2, $3, $4, $5, $6)", 
                    unqid, level, parent_id, post_id, content, author_id

            rescue ex
                pp ex
                store.status = "error"
                store.message = ex.message.to_s

                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.status_code = 500
                ctx.response.print Cove::Layout.render(store, Cove::Views.error500)
            else
                store.status = "success"
                store.message = "Comment was successfully added"
                Cove::Router.redirect("/p/#{post_id}", ctx)
            end
        end
    end
end
