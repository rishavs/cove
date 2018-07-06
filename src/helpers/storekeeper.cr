class Store 
    property currentuser : Nil | Hash(String, String) = nil

    def currentuser
        @currentuser
    end

    def currentuser (data)
        @currentuser = data
    end
end