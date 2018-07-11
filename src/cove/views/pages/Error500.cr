module Cove
    class Views
        def self.error500
            html = <<-HTML
                <article id="error500_page">
                    <h1>Something is broken</h1>
                    <p> Could be my heart. Could be the server. Who knows  T_T</p>
                </article>
            HTML
        end
    end

end