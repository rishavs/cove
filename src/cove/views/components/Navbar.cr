module Cove::Views
    def self.navbar
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
                    <a href="/register" >Register</a>
                </div>
                <div class="item">
                    <a href="/login" class="ui blue button" >Login</a>
                </div>
            </div>
            </div>
        HTML
    end
end