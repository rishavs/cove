module Cove
    class Views
        def self.home(posts)
            items = ""
            posts.each do |post|
                items = items + 
                    "<li><a href='/p/#{post["unqid"]}'> #{post["title"]} </a></li>"
            end

            html = <<-HTML
                <article id="home_page">
                    <h1>HOME</h1>
                    <ol>
                        #{items}
                    </ol>
                </article>
            HTML
        end
    end
end