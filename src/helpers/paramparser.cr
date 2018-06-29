module Cove
    class Parse
        def self.form_params(body : IO)
            HTTP::Params.parse(body.gets_to_end)
        end
        def self.form_params(body : Nil)
            HTTP::Params.parse("")
        end
    end
end