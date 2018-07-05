module Cove
    class Views
        def self.register(store)
            html = <<-HTML
                <article id="register_page">
                    <h1>Register </h1>
                    <form class="ui form" id="register_form" action="/register" method="post" onsubmit="reset_password_input()>
                        <div class="field">
                            <label>Username</label>
                            <input type="text" name="username" id="username" placeholder="Username" />
                        </div>
                        <div class="field">
                            <label>Password</label>
                            <div class="ui icon input">
                                <input type="password" name="password" id="password" placeholder="Password" />
                                <i class="circular eye slash outline link icon" id="toggle_password" onclick="toggle_password()"></i>
                            </div>
                        </div>
                
                        <button class="ui button" type="submit" >Submit</button>
                
                        <div class="ui error message"></div>
                    </form>
                </article>
                
                <script>
                    const toggle_password = () => {
                        var p = document.getElementById("password");
                        var tp = document.getElementById("toggle_password");
                        if (p.type === "password") {
                            p.type = "text";
                            tp.classList.remove("circular", "eye", "slash", "outline", "link", "icon")
                            tp.classList.add("circular", "eye", "link", "icon")
                            
                        } else {
                            p.type = "password";
                            tp.classList.remove("circular", "eye", "link", "icon")
                            tp.classList.add("circular", "eye", "slash", "outline", "link", "icon")
                        }
                    }
                    
                    const reset_password_input = () => {
                        var p = document.getElementById("password");
                        if (p.type === "text") {
                            p.type = "password"
                        }
                    }

                </script>
            HTML
        end
    end
end