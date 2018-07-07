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
                title = title.downcase.lstrip.rstrip
                link = link.downcase.lstrip.rstrip
                content = content.downcase.lstrip.rstrip

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
    end
end
