module Cove
    class Views
        def self.comments(cmt, ctree)
            
            children = ""
            cmt.children_ids.each do |chid|
                children = children + Cove::Views.comments(ctree[chid], ctree)
            end

            if cmt.children_ids.size > 0
                children_view = <<-HTML 
                    <div class="comments">
                        #{children}
                    </div>
                HTML
            else
                children_view = ""
            end
            
            comments= <<-HTML
                <div class="comment" comment_id="#{cmt.unqid}" >
                    <a class="avatar">
                        <img src="http://via.placeholder.com/50x50.png" />
                    </a>
                    <div class="content">
                        <a class="author">Someone Mc Someone</a>
                        <div class="metadata">
                            <span class="date"><i class="clock icon"></i> Today at 5:42PM</span>
                        </div>
                        <div class="text">
                            #{cmt.content}
                        </div>
                        <div class="actions">
                            <a class="reply">Like (250) <i class="heart outline icon"></i></a>
                            <a class="reply" onclick={}> Reply (2110) <i class="reply icon"></i></a>
                            <a class="bookmark" > Bookmark <i class="bookmark outline icon"></i></a>
                            <a class="edit"> Edit <i class="edit icon"></i></a>
                            <a class="delete"> Delete <i class="trash icon"></i></a>
                        </div>
                        <form class="ui reply form" id="reply_for_id:#{cmt.unqid}" style="display:none" onsubmit={()} >
                            <div class="field">
                                <textarea
                                    id={"textarea_for_id:" + vnode.attrs.comment.id}
                                    class="textarea"
                                    placeholder="Content"
                                >
                                </textarea>
                            </div>
                            <button class="ui primary submit labeled icon button" >
                                <i class="icon edit"></i> Add Reply
                            </button>
                            <br />
                            <br />
                        </form>
                    </div>
                    #{children_view}

                </div>
            HTML

        end
    end
end