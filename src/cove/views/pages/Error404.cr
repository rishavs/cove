module Cove
    class Views
        def self.error404
            html = <<-HTML
                <article id="error404_page">
                    <h1>Not all who wander are lost</h1>
                    <p> You might be though, as this page doesnt exists :/</p>
                </article>
            HTML
        end
    end

end