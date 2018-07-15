module Cove
    class Posts
        def self.new_post(ctx)
            store = Cove::Store.new
            store.currentuser = Cove::Auth.check(ctx)

            ctx.response.content_type = "text/html; charset=utf-8"    
            ctx.response.print Cove::Layout.render( store, Cove::Views.new_post)
        end

        def self.create(ctx)
            store = Cove::Store.new
            store.currentuser = Cove::Auth.check(ctx)

            begin
                params =    Cove::Parse.form_params(ctx.request.body)
                title =  params.fetch("title")
                link =  params.fetch("link")
                content = params.fetch("content")
                if store.currentuser["loggedin"] == "true"
                    author_id = store.currentuser["unqid"]
                else
                    raise Exception.new("Unable to fetch user details. Are you sure you are logged in?")
                end

                # Trim leading & trailing whitespace
                title = title.lstrip.rstrip
                link = link.lstrip.rstrip
                content = content.lstrip.rstrip

                # Validation checks
                Cove::Validate.if_length(title, "title", 3, 128)
                Cove::Validate.if_length(link, "link", 3, 1024)
                Cove::Validate.if_length(content, "content", 3, 2048)

                # Generate some data
                unqid = UUID.random.to_s
                
                # DB operations
                Cove::DB.exec "insert into posts (unqid, title, link, content, author_id) values ($1, $2, $3, $4, $5)", unqid, title, link, content, author_id

            rescue ex
                pp ex
                store.status = "error"
                store.message = ex.message.to_s

                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.print Cove::Layout.render( store, Cove::Views.new_post)
            else
                store.status = "success"
                store.message = "Post was success fully added"
                Cove::Router.redirect("/p/#{unqid}", ctx)
            end
        end
        def self.read(ctx, postid)
            store = Cove::Store.new
            store.currentuser = Cove::Auth.check(ctx)

            begin
                # Get nil if the post doesnt exists. Else get the NamedTuple
                post = Cove::DB.query_one? "select unqid, title, content, link, author_id from posts where unqid = $1", postid, 
                    as: {unqid: String, title: String, content: String, link: String, author_id: String}

                comments = Cove::DB.query_all "select unqid, level, post_id, parent_id,  content, author_id from comments where post_id = $1", postid,                   
                    as: {unqid: String, level: Int, post_id: String, parent_id: String , content: String, author_id: String}

                    pp comments
            rescue ex
                # Currently we get error with "no rows" if table is empty. But will not handle it as it wouldn't happen in practice.
                pp ex
                store.status = "error"
                store.message = ex.message.to_s

                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.status_code = 500
                ctx.response.print Cove::Layout.render(store, Cove::Views.error500)
            else
                if post != nil
                    store.status = "success"
                    store.message = "Post data was retreived"

                    ctx.response.content_type = "text/html; charset=utf-8"    
                    ctx.response.print Cove::Layout.render(store, Cove::Views.show_post(post, comments))
                else
                    store.status = "error"
                    store.message = "The post doesn't exists"

                    ctx.response.content_type = "text/html; charset=utf-8"    
                    ctx.response.status_code = 404
                    ctx.response.print Cove::Layout.render(store, Cove::Views.error404)
                end
            end
        end

        def self.list(ctx)
            store = Cove::Store.new
            store.currentuser = Cove::Auth.check(ctx)

            begin
               posts = Cove::DB.query_all "select unqid, title, content, link, author_id from posts",                   
                    as: {unqid: String, title: String, content: String, link: String, author_id: String}
            rescue error
                pp error
                store.status = "error"
                store.message = error.message.to_s
            else
                store.status = "success"
                store.message = "Received the db response"
            
                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.print Cove::Layout.render( store, Cove::Views.home(posts))
            end
        end
    end
end
