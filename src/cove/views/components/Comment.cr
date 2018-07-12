module Cove
    class Views
        def self.comment(comment)
            html = <<-HTML
                <div class="comment" comment_id={vnode.attrs.comment.id} >
                    <a class="avatar">
                        <img src="http://via.placeholder.com/50x50.png" />
                    </a>
                    <div class="content">
                        <a class="author">{vnode.attrs.comment.data().author}</a>
                        <div class="metadata">
                            <span class="date"><i class="clock icon"></i> Today at 5:42PM</span>
                        </div>
                        <div class="text">

                            {vnode.attrs.comment.data().content}
                        </div>
                        <div class="actions">
                            <a class="reply">Like (250) <i class="heart outline icon"></i></a>
                            <a class="reply" onclick={() => vnode.state.actions.toggle_comment_reply(vnode.attrs.comment.id)}> Reply (2110) <i class="reply icon"></i></a>
                            <a class="bookmark" > Bookmark <i class="bookmark outline icon"></i></a>
                            <a class="edit"> Edit <i class="edit icon"></i></a>
                            <a class="delete"> Delete <i class="trash icon"></i></a>
                        </div>
                        <form class="ui reply form" id={"reply_for_id:" + vnode.attrs.comment.id} style="display:none" onsubmit={() => vnode.state.actions.handle_submit(vnode.attrs.comment)} >
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
                        {vnode.attrs.comment.children.map(com_child => <Comment comment={com_child} />)}
                    </div>
                </div>
            HTML

        end
    end
end