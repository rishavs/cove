module Cove
    class ValidationError < Exception
    end

    class Validate
        def self.if_unique(itemval, itemname, dbtable)
            raise Cove::ValidationError.new("The #{itemname} already exists.")
        end
        def self.if_length(itemval, itemname, min, max)
            if !(min <= itemval.size <= max)
                raise Cove::ValidationError.new("The #{itemname} should be between #{min} and #{max} chars long.")
            end
        end
    end


end