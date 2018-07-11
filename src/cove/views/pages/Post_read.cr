module Cove
    class Views
        def self.show_post(post)
            html = <<-HTML
                <article id="read_post_page">
                    <h1>#{post[:title]}</h1>
                    <div class="ui items">
                        <div class="item">
                            <div class="ui medium image">
                                <img src=http://via.placeholder.com/350x350.png />
                            </div>

                            <div class="content">
                                <div class="ui comments" style="max-width: 100%">
                                    <div class="comment">
                                        <a class="avatar">
                                            <img src="http://via.placeholder.com/50x50.png" />
                                        </a>
                                        <div class="content">
                                            <a class="author">Matt</a>
                                            <div class="metadata">
                                                <div class="date"> <i class="clock icon"></i> 2 days ago</div>
                                                <div class="rating">
                                                    <i class="star icon"></i>
                                                    5 Faves
                                                </div>
                                            </div>

                                            <div class="text">
                                                #{post[:content]}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="actions">
                        <button class="ui right labeled icon small basic button" >
                            <i class="heart outline icon"></i>
                            1024
                        </button>
                        <button class="ui right labeled icon small basic button" >
                            <i class="reply icon"></i>
                            2048
                        </button>
                        <button class="ui icon small button" >
                            <i class="ellipsis vertical icon"></i>
                        </button>

                    </div>
                    <form class="ui reply form" id="reply_for_post" style="display:none" onsubmit={actions.handle_submit}>
                        <br />

                        <div class="field">
                            <textarea
                                id="textarea_for_post_reply"
                                class="textarea"
                                placeholder="Content"
                            >
                            </textarea>
                        </div>
                        <div class="ui blue labeled submit icon button" onclick={actions.handle_submit}>
                            <i class="icon edit"></i> Add Reply
                        </div>
                    </form>
                    
                    <h3 class="ui dividing header">Comments</h3>
                    <div class="ui threaded comments" style="max-width: 100%">
                        {comments_map.map(comment => <Comment comment={comment}/> )}
                    </div>
                </article>
            HTML
        end
    end

end