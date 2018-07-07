module Cove
    class Layout
        def self.render(page, store)
            html = <<-HTML
                <!doctype html>
                <html class="no-js" lang="">
                    <head>
                        <meta charset="utf-8">
                        <meta http-equiv="x-ua-compatible" content="ie=edge">
                        <title>Digglu</title>
                        <meta name="description" content="Because the time you enjoyed wasting wasn't wasted!">
                        <meta name="viewport" content="width=device-width, initial-scale=1">
                        <link href="data:image/x-icon;base64,AAABAAEAEBAAAAEAIABoBAAAFgAAACgAAAAQAAAAIAAAAAEAIAAAAAAAAAQAABILAAASCwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMAAAAOwAAADdAAAAxQAAAPYAAABfAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADYAAAD+AAAA/wAAAP8AAAD/AAAAcQAAAAAAAABEAAAAjQAAAE8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAcAAADMAAAA/wAAAP8AAAD/AAAA/wAAAOwAAACfAAAA/gAAAOUAAAD+AAAASwAAAAAAAAAAAAAAAAAAAAAAAABhAAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA9QAAAHIAAAADAAAA0AAAAKIAAAAAAAAAAAAAAAAAAAAAAAAAkgAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAM0AAAAAAAAAAAAAAJMAAACUAAAAAAAAAAAAAAAPAAAABgAAAHQAAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAACwAAAAAQAAABUAAAABAAAAAQAAAAAAAAAAAAAAKQAAAFkAAACrAAAA/wAAAP8HBgX/Dw4O/wAAAP8AAAD/AAAA0QAAAF4AAAA7AAAAAAAAAAAAAAAAAAAAAAAAABMAAAB1AAAA/xwoKv8fLC//FBMT/yUkI/8RGRr/Kjo+/wAAAP8AAAClAAAAHgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAs4a8yv//////8////1t/iP8aJCb////////////S////AAAA7QAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM+h4vH//////3alsf8SGRv/AAAA/2+cp//1////5f///wAAAP8AAAAMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACoAAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAADkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAeQAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAAtQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHmCh87/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/Wl6P/zk7WrQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB5tb3//wAAAP8AAAD7AAAA0gAAANYAAADvAAAA/4iN1/8+QGK0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAeTU3VP8AAADgAAAAPAAAAAAAAAAAAAAAHgAAAMITEx7/LC1GtAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGwAAACuAAAAEgAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAgwAAAKQAAAAAAAAAAAAAAAAAAAAA8D8AAPABAADgAQAA4AEAAOAZAACAAQAAgAMAAIADAADABwAAwAcAAMAHAADADwAAwA8AAMAPAADDDwAAx48AAA==" rel="icon" type="image/x-icon">
                        <link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/semantic-ui@2.3.1/dist/semantic.min.css">
                        #{Cove::Views.css}
                    </head>
                    <body>
                        #{Cove::Views.navbar(store)}

                        <div id = "home_page" class="ui main container pageExit">
                            #{Cove::Views.flash(store)}
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
end

