module Cove
    class Views
        def self.show_post(post, comments)
            items = ""
            comments.each do |comment|
                items = items + 
                    "<li><a href='/p/#{post["unqid"]}'> #{post["title"]} </a></li>"
            end

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
                        <button class="ui right labeled icon small basic button" onclick="toggle_post_reply()">
                            <i class="reply icon"></i>
                            2048
                        </button>
                        <button class="ui icon small button" >
                            <i class="ellipsis vertical icon"></i>
                        </button>

                    </div>
                    <form class="ui reply form" id="post_reply_btn" style="display:none" action="/p/#{post[:unqid]}/comment" method="post">
                        <br />

                        <div class="field">
                            <textarea
                                id="post_reply_field"
                                name="post_reply_field"
                                class="textarea"
                                placeholder="Content"
                            >
                            </textarea>
                        </div>
                        <button class="ui button" type="submit" >Submit</button>
                    </form>
                    
                    <h3 class="ui dividing header">Comments</h3>
                    <div class="ui threaded comments" style="max-width: 100%">
                        #{comments}
                    </div>
                </article>

                <script>
                const toggle_post_reply = () => {
                    // ensure user is logged in to use this action
                    // utils.redirect_to_login_if_not_loggedin()
            
                    var component = document.getElementById("post_reply_btn")
                    if (component.style.display === 'none') {
                        component.style.display = 'block';
                        
                        // this bit is mainly for a smoother transition
                        document.getElementById("post_reply_btn").scrollIntoView({ behavior: "smooth", block: "center", inline: "center" })
                        document.getElementById("post_reply_btn").focus();

                    } else {
                        component.style.display = 'none';
                    }

                }
                </script>
            HTML
        end
    end

end