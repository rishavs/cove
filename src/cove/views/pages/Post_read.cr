module Cove
    class Views
        def self.read_post(store)
            html = <<-HTML
                <article id="read_post_page">
                    <h1>ABOUT ME:</h1>
                    <p> I are awesome</p>
                </article>
            HTML
        end
    end

end