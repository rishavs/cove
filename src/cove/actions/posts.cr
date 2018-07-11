module Cove
    class Posts
        def self.create(ctx, userid)
            store = Cove::Store.new

            begin
                params =    Cove::Parse.form_params(ctx.request.body)
                title =  params.fetch("title")
                link =  params.fetch("link")
                content = params.fetch("content")
                authorid = userid

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
                Cove::DB.exec "insert into posts (unqid, title, link, content, authorid) values ($1, $2, $3, $4, $5)", unqid, title, link, content, authorid

            rescue ex
                pp ex
                store.status = "error"
                store.message = ex.message.to_s
                store.data = {"none" => "none"}

                store
            else
                store.status = "success"
                store.message = "Post was success fully added"
                store.data = {"postid" => unqid, "posttitle" => title}

                store
            end
        end
        def self.read(ctx, postid)
            store = Cove::Store.new

            begin
                # Get nil if the post doesnt exists. Else get the NamedTuple
                post = Cove::DB.query_one? "select unqid, title, content, link, authorid from posts where unqid = $1", postid, 
                    as: {unqid: String, title: String, content: String, link: String, authorid: String}
            rescue ex
                pp ex
                store.status = "error"
                store.message = ex.message.to_s

                ctx.response.content_type = "text/html; charset=utf-8"    
                ctx.response.status_code = 500
                ctx.response.print Cove::Layout.render(store, Cove::Views.error500)
            else
                if post != nil
                    pp postid

                    store.status = "success"
                    store.message = "Post data was retreived"

                    ctx.response.content_type = "text/html; charset=utf-8"    
                    ctx.response.print Cove::Layout.render(store, Cove::Views.show_post(post))
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
               posts = Cove::DB.query_all "select unqid, title, content, link, authorid from posts",                   
                    as: {unqid: String, title: String, content: String, link: String, authorid: String}
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
