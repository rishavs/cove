module Cove
    class Views
        def self.new_post(store)
            html = <<-HTML
                <article id="new_post_page">
                    <form class="ui form" id="new_post_form" action="/post/new/" method="post">
                        <div class="field">
                            <label class="label">Title</label>
                            <input class="input" name="title" type="text" placeholder="Title"/>
                        </div>
                        <div class="field">
                            <label class="label">Link</label>
                            <input class="input" name="link" type="text" placeholder="Link"/>
                        </div>
                        <div class="field">
                            <label class="label">Content</label>
                            <textarea class="textarea" name="content" placeholder="Content"> </textarea>
                        </div>
                        <button class="ui button" type="submit" >Submit</button>
                    </form>
                </article>
            HTML
        end
    end

end