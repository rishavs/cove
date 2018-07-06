module Cove
    class Views
        def self.js
            html = <<-HTML
                <script>
                    console.log("Hallo. Dis be browser")
                </script>
            HTML
        end
    end
end