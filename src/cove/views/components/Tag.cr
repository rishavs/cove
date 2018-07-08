module Cove
    class Views
        def self.tag(store)
            html = <<-HTML
                <div class="ui small basic icon buttons" style=" margin:2px ;">
                    <button class="ui button" onclick={() => actions.click_tag(vnode.attrs.tagName)}>
                        {vnode.attrs.tagName + " (" + vnode.attrs.tagScore + ")"}
                    </button>

                    {firebase.auth().currentUser ?

                        <div >
                            <button class="ui button" onclick={() => actions.upvote_tag(vnode.attrs.tagName)}>
                                <i class="thumbs up icon"></i>
                            </button>
                            <button class="ui button" onclick={() => actions.downvote_tag(vnode.attrs.tagName)}>
                                <i class="thumbs down icon"></i>
                            </button>
                        </div>

                        : null

                    }
                </div>
            HTML
        end
    end
end