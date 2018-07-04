module Cove
    class Views
        def self.js
            html = <<-HTML
                <script>
                    console.log("Hallo from the Cove")
                </script>
            HTML
        end
    end
end