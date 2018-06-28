module Cove::Layout
    def self.render(page)
        html = <<-HTML
            <!doctype html>
            <html class="no-js" lang="">
                <head>
                    <meta charset="utf-8">
                    <meta http-equiv="x-ua-compatible" content="ie=edge">
                    <title>Digglu</title>
                    <meta name="description" content="Because the time you enjoyed wasting wasn't wasted!">
                    <meta name="viewport" content="width=device-width, initial-scale=1">
            
                    <link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/semantic-ui@2.3.1/dist/semantic.min.css">
                    #{Cove::Views.css}
                </head>
                <body>
                    #{Cove::Views.navbar}

                    <div id = "home_page" class="ui main container pageExit">
                        #{ page }
                    </div>
            
                    <script src="http://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha256-3edrmyuQ0w65f8gfBsqowzjJe2iM6n0nKciPUp8y+7E=" crossorigin="anonymous"></script>
                    <script src="http://cdn.jsdelivr.net/npm/semantic-ui@2.3.1/dist/semantic.min.js"></script>
                    #{Cove::Views.js}
                </body>
            </html>
        HTML
    end
end

