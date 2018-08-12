module Cove
    class Views
        def self.post_read(post_data, ctree)
            if ctree.size == 0
                comments_view = "<h4>Doesn't looks like anything to me.</h4>"
            else
                comments_view = ""
                ctree.each do |id, cmt|
                    if cmt.parent_id == "none" && cmt.level == 0
                        comments_view = comments_view + Cove::Views.comments(cmt, ctree)
                    end
                end

                comments_view = <<-HTML
                    <div class="ui comments" style="max-width: 100%">
                        #{comments_view}
                    </div>
                HTML
            
            end

            html = <<-HTML
                <article id="read_post_page">
                    <h1>#{post_data[:title]}</h1>
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
                                            <a class="author">#{post_data[:author_nick]}</a>
                                            <div class="metadata">
                                                <div class="date"> <i class="clock icon"></i> 2 days ago</div>
                                                <div class="rating">
                                                    <i class="star icon"></i>
                                                    5 Faves
                                                </div>
                                            </div>

                                            <div class="text">
                                                #{post_data[:content]}
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
                        <button class="ui right labeled icon small basic button" onclick="toggle_post_reply()">
                            <i class="reply icon"></i>
                            2048
                        </button>
                        <button class="ui icon small button" >
                            <i class="ellipsis vertical icon"></i>
                        </button>

                    </div>
                    
                    <form class="ui reply form" id="reply_form" style="display:none" action="/c/new/" method="post">
                        <br />
                        <input name="parent_id" value="none" style="display:none"></input>
                        <input name="post_id" value="#{post_data[:unqid]}" style="display:none"></input>
                        <input name="level" value="0" style="display:none"></input>
                        <div class="field">
                            <textarea
                                id="textarea_reply_form"
                                class="textarea"
                                name="content"
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
                    
                    <h3 class="ui dividing header">Comments</h3>
                    #{comments_view}
                </article>
            HTML
        end
    end

end