module Cove
    class Views
        def self.welcome (store)
            html = <<-HTML
                <article id="welcome_page">
                    <h1>Hey #{store["data"]["username"]}</h1>
                    <p> Welcome to the Cove!</p>
                    <p> Just give me a moment while I log you in...</p>
                <article id="register_page">

                <script>
                    window.onload = () => {
                        localStorage.setItem("user_unqid", "#{store["data"]["unqid"]}" );
                        localStorage.setItem("user_username","#{store["data"]["username"]}" );
                        localStorage.setItem("user_token","#{store["data"]["token"]}" );
                    };
                </script>
            HTML
        end
    end
end