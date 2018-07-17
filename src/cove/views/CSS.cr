module Cove
    class Views
        def self.css
            html = <<-HTML
                <style type="text/css">
                    .main.container {
                        margin-top: 6em;
                        margin-bottom: 6em;
                    }

                    .shadedText {
                        line-height: 1;
                        text-shadow: 0 1px 0 rgba(255, 255, 255, 0.75);
                        color: #484848;
                        letter-spacing: -0.035em;
                    }
                </style>
            HTML
        end
    end
end
