# ChatApp


# Technologies
  * Ruby v(2.7.1)
  * Rails v(5.1.7)
  * Mysql v(8.0)
  * Redis v(4.6)
  * Elasticsearch v(7.13.3)

# Steps To Run the app
Install docker and docker-compose before starting this installation process.

1. Clone the Repository
2. Execute "docker-compose up" in the project directory


# API Endpoints

## App
#### GET All Apps
    GEt: localhost:3000/apps
#### CREATE App
    POST: localhost:3000/apps
    Request Example
    localhost:3000/apps?name=name-here

#### GET App By Token
    GET localhost:3000/apps/:token
#### UPDATE App By Token
    PUT localhost:3000/apps/:token
    Request Example
    localhost:3000/apps/:token?name=testName
## Chat
#### GET All Chats
    GET localhost:3000/apps/:app_token/chats
#### CREATE Chat
    POST: localhost:3000/apps/:app_token/chats
#### GET Chat By Number
    GET: localhost:3000/apps/:app_token/chats/:number
## Messages
#### GET All Messages
    GET: localhost:3000/apps/:app_token/chats/:chat_number/messages
#### CREATE Message
    POST: localhost:3000/apps/:app_token/chats/:chat_number/messages
    Request Example
    localhost:3000/apps/:app_token/chats/:chat_number/messages?content=content-here
#### SEARCH Messages By Query
    POST: localhost:3000/apps/:app_token/chats/:chat_number/messages/search
    Request Example
      localhost:3000/apps/:app_token/chats/:chat_number/messages/search?search=search-here
#### GET Chat By Number
    GET: localhost:3000/apps/:app_token/chats/:chat_number/messages/:number
#### UPDATE Chat
    PUT: localhost:3000/apps/:app_token/chats/:chat_number/messages/:number
    Request Example
    localhost:3000/apps/:app_token/chats/:chat_number/messages/:number?content=content-here

