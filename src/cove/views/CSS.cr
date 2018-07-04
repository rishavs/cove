module Cove
    class Views
        def self.css
            html = <<-HTML
                <style type="text/css">
                    .main.container {
                        margin-top: 6em;
                    }
                </style>
            HTML
        end
    end
end
