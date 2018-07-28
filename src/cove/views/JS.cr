module Cove
    class Views
        def self.js
            html = <<-HTML
                <script>
                    console.log("Hallo. Dis be browser")

                    const toggle_post_reply = () => {
                        // ensure user is logged in to use this action
                        // utils.redirect_to_login_if_not_loggedin()
                
                        var component = document.getElementById("reply_form")
                        if (component.style.display === 'none') {
                            component.style.display = 'block';
                            
                            // this bit is mainly for a smoother transition
                            document.getElementById("textarea_reply_form").scrollIntoView({ behavior: "smooth", block: "center", inline: "center" })
                            document.getElementById("textarea_reply_form").focus();
    
                        } else {
                            component.style.display = 'none';
                        }
    
                    }

                    const toggle_comment_reply = (id) => {
                        // ensure user is logged in to use this action
                        // utils.redirect_to_login_if_not_loggedin()
            
                        var component = document.getElementById("comment_for_id:" + id)
                        if (component.style.display === 'none') {
                            component.style.display = 'block';
            
                            // this bit is mainly for a smoother transition. Broken in chrome
                            document.getElementById("textarea_for_id:" + id).scrollIntoView({ behavior: "smooth", block: "center", inline: "center" })
                            document.getElementById("textarea_for_id:" + id).focus();
                        } else {
                            component.style.display = 'none';
                        }
                    }
                </script>
            HTML
        end
    end
end