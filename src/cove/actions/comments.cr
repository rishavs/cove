module Cove
    class Comment

        def self.create(ctx)
            store = Cove::Store.new
            store.currentuser = Cove::Auth.check(ctx)

            begin
                params =    Cove::Parse.form_params(ctx.request.body)
                Cove::Validate.if_loggedin(store.currentuser)
                
                post_id =  params.fetch("post_id")
                parent_id =  params.fetch("parent_id")
                level = params.fetch("level").to_i
                content = params.fetch("content")
                author_id = store.currentuser["unqid"]
                
                # Trim leading & trailing whitespace
                content = content.lstrip.rstrip

                # Validation checks
                Cove::Validate.if_length(content, "content", 3, 2048)

                # Generate some data
                unqid = UUID.random.to_s
                
                # DB operations
                Cove::DB.exec "insert into comments (unqid, level, parent_id, post_id, content, author_id) values ($1, $2, $3, $4, $5, $6);", 
                    unqid, level, parent_id, post_id, content, author_id
                if parent_id == "none" && level > 0
                    Cove::DB.exec "UPDATE comments SET children_ids = children_ids || '{$1}' WHERE unqid = $2;", unqid, parent_id
                end

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
