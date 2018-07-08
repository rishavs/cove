module Cove
    class Views
        def self.navbar(store)
            if store.currentuser["loggedin"] == "true"
                navcontrols = <<-HTML
                    <div class="item">
                        <a href="/p/new/" class="ui blue button" >New Post</a>
                    </div>
                    <div class="item">
                        <a href="/logout" >Logout</a>
                    </div>
                HTML
            else
                navcontrols = <<-HTML
                    <div class="item">
                        <a href="/register" >Register</a>
                    </div>
                    <div class="item">
                        <a href="/login" class="ui blue button" >Login</a>
                    </div>
                HTML
            end

            html = <<-HTML
                <div class="ui fixed menu">
                    <div class="ui container">
                        <a href="/" class="header item" >
                            Digglu
                        </a>
                        <div class="item">
                            <a href="/about" >About</a>
                        </div>
                        <div class="item">
                            <a href="/secret" >Secret</a>
                        </div>
                        #{navcontrols}
                    </div>
                </div>
            HTML
        end
    end
end