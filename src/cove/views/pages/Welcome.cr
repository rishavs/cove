module Cove
    class Views
        def self.welcome (store)
            html = <<-HTML
                <h1>Hello #{store["data"]["username"]}</h1>
                <p> Your UserId is: #{store["data"]["userid"]}</p>
            HTML
        end
    end
end