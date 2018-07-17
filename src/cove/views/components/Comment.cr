module Cove
    class Views
        def self.comment_tree(comments_data)
                comments_view = ""
                comments_data.each do |cmt_data|
                    if cmt_data[:parent_id] == "none" && cmt_data[:level] == 0
                        children = ""
                        cmt_data[:children_ids].each do |child|
                            children =  children + Cove::Views.comment_tree(comments_data[child])
                        end

                        comments_view = comments_view + Cove::Views.comment_tree(cmt_data)
                    end

                
                comments= <<-HTML
                    <div class="comment" comment_id="#{cmt_data[:unqid]}" >
                        <a class="avatar">
                            <img src="http://via.placeholder.com/50x50.png" />
                        </a>
                        <div class="content">
                            <a class="author">Someone Mc Someone</a>
                            <div class="metadata">
                                <span class="date"><i class="clock icon"></i> Today at 5:42PM</span>
                            </div>
                            <div class="text">

                                #{cmt_data[:content]}
                            </div>
                            <div class="actions">
                                <a class="reply">Like (250) <i class="heart outline icon"></i></a>
                                <a class="reply" onclick={}> Reply (2110) <i class="reply icon"></i></a>
                                <a class="bookmark" > Bookmark <i class="bookmark outline icon"></i></a>
                                <a class="edit"> Edit <i class="edit icon"></i></a>
                                <a class="delete"> Delete <i class="trash icon"></i></a>
                            </div>
                            <form class="ui reply form" id="reply_for_id:#{cmt_data[:unqid]}" style="display:none" onsubmit={()} >
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
                            #{children}
                            <!-- {vnode.attrs.comment.children.map(com_child => <Comment comment={com_child} />)} -->
                        </div>
                    </div>
                HTML

                html = <<-HTML
                    <div class="ui threaded comments" style="max-width: 100%">
                        #{comments}
                    </div>
                HTML
            end
        end
    end
end