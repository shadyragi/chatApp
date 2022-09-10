class ChatsController < ApplicationController
  before_action :set_chat, only: [:show]
  before_action :set_app, only: [:create]


  # GET /chats
  def index
    @chats = Chat.where(appToken: params[:appToken])

    render json: @chats.as_json(except: [:id])
  end

  # GET /chats/1
  def show
    render json: @chat.as_json(except: [:id])
  end

  # POST /chats
  def create
    @chat = Chat.new(appToken: params[:appToken], number: 0)

    raise ActiveRecord::RecordInvalid.new(@chat) if !@chat.valid?

    @chat_number = $redis.incr(params[:appToken].to_s)

    @chat.number = @chat_number
    
    @chat.save!

    @app.chatCount = @chat_number

    @app.save!

    render json: {'chat_number': @chat_number}, status: :created
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find_by!(appToken: params[:appToken], number: params[:number])
    end

    def set_app
      @app = App.find_by!(token: params[:appToken])
    end

    # Only allow a trusted parameter "white list" through.
    def chat_params
      params.require(:chat).permit(:appToken)
    end
end
