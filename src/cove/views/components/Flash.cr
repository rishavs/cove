module Cove::Views
    def self.flash
        html = <<-HTML
            <div class="ui fixed menu">
            <div class="ui container">
                <a href="/" class="header item" >
                    Digglu
                </a>
                <div class="item">
                    <a href="/about" >About</a>
                </div>
                <div class="item">
                    <a href="/register" >Register</a>
                </div>
                <div class="item">
                    <a href="/login" class="ui blue button" >Login</a>
                </div>
            </div>
            </div>
        HTML
    end
end

# <%= env.get("store") -%>
# <%- pp env.get("store") -%>
# <%- if res["status"] == "error" -%>
#     <div class="ui message">
#         <div class="header">
#             There be dragons
#         </div>
#         <p> <%= res["message"] -%> </p>"
#     </div>
# <%- end -%>