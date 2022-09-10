Rails.application.routes.draw do

    get "/apps", to: "apps#index"
    post "/apps", to: "apps#create"
    get "/apps/:token", to: "apps#show"
    put "/apps/:token", to: "apps#update"

  # End Apps Routes

  # Start Chat Routes

    get "/apps/:appToken/chats", to: "chats#index"
    post "/apps/:appToken/chats", to: "chats#create"
    get "/apps/:appToken/chats/:number", to: "chats#show"

  # End Chat Routes

  # Start message Routes

    get "/apps/:appToken/chats/:chatNumber/messages", to: "messages#index"
    post "/apps/:appToken/chats/:chatNumber/messages", to: "messages#create"
    post "/apps/:appToken/chats/:chatNumber/messages/search", to: "messages#search"
    get "/apps/:appToken/chats/:chatNumber/messages/:number", to: "messages#show"
    put "/apps/:appToken/chats/:chatNumber/messages/:number", to: "messages#update"
end
