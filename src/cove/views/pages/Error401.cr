module Cove
    class Views
        def self.error401
            html = <<-HTML
                <article id="error401_page">
                    <h1>401 Unauthorised Access </h1>
                    <p> Warning. Prosectors will be trespassed.</p>
                </article>
            HTML
        end
    end

end