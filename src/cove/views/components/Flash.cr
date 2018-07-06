module Cove
    class Views
        def self.flash(store)
            if store.status == "error"
                html = <<-HTML
                    <div class="ui negative message">
                        <div class="header">
                            #{store.message}
                        </div>
                    </div>
                HTML
            end
        end
    end
end