module Cove::Views
    class Home

        @@html = <<-HTML
            <h1>THIS IS HOME</h1>
        HTML

        def self.render
            @@html
        end
    end
end