module Cove
    class Views
        def self.home(store)
            html = <<-HTML
                <article id="home_page">
                    <h1>HOME</h1>
                </article>
            HTML
        end
    end
end