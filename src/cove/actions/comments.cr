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

        def self.branchify(list)
            # https://carc.in/#/r/4iwp

            # list.each do |item|
            #     parentId = item[:parent_id] || 0;


            # end

            # var tree = [],
            # childrenOf = {};
            # var item, id, parentId;
        
            # docs.forEach((item) => {

            #     id = item.id;
            #     parentId = item.data().parent_id || 0;
            #     // every item may have children
            #     childrenOf[id] = childrenOf[id] || [];
            #     // init its children
            #     item.children = childrenOf[id];
            #     if (parentId != 0) {
            #         // init its parent's children object
            #         childrenOf[parentId] = childrenOf[parentId] || [];
            #         // push it into its parent's children object
            #         childrenOf[parentId].push(item);
            #     } else {
            #         tree.push(item);
            #     }
            # })
        # 
            # tree
        end
    end
end
