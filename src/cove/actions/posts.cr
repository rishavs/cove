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
                # DB operations
                post = Cove::DB.query_one? "select unqid, title, content, link, authorid from posts where unqid = $1", postid, 
                    as: {unqid: String, title: String, content: String, link: String, authorid: String}

            rescue ex
                pp ex
                store.status = "error"
                store.message = ex.message.to_s
                store.data = {"none" => "none"}

                store
            else
                if post != nil
                    store.status = "success"
                    store.message = "Post was successfully added"
                    store.data = {
                        "unqid" => post[:unqid], 
                        "title" =>  post[:title], 
                        "link" =>  post[:link], 
                        "content" =>  post[:content], 
                        "authorid" =>  post[:authorid]
                    }

                    store
                else
                    store.status = "error"
                    store.message = "The post doesn't exists"
                    store.data = {"none" => "none"}
                    
                    store
                end
            end
        end
    end
end
