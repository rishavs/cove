module Cove::Models
    class Comment
        property unqid : String
        property parent_id : String
        property level : Int32
        property post_id : String
        property content : String
        property author_id : String
      
        def initialize(@unqid, @level,  @post_id, @parent_id, @content, @author_id)
        end
    end

    class CommentTree
        property unqid : String
        property parent_id : String
        property level : Int32
        property post_id : String
        property content : String
        property author_id : String
        property children = [] of CommentTree
      
        def self.seed(cm : Comment)
          new(cm.unqid, cm.parent_id, cm.level, cm.post_id, cm.content, cm.author_id)
        end
      
        def initialize(@unqid, @level,  @post_id, @parent_id, @content, @author_id)
        end
    end

end
