module Cove::Models
    class CommentTree
        property unqid : String
        property parent_id : String
        property level : Int32
        property post_id : String
        property content : String
        property author_id : String
        property children = [] of CommentTree
      
        def initialize(@unqid, @level,  @post_id, @parent_id, @content, @author_id)
        end
    end

end
