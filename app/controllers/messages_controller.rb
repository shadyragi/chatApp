class MessagesController < ApplicationController
  before_action :set_chat
  before_action :set_message, only: [:show, :update]

  # GET /messages
  def index
    @messages = Message.where(chat_id: @chat.id)

    render json: @messages.as_json(except: [:id])
  end

  # GET /messages/1
  def show
    render json: @message.as_json(except: [:id])
  end

  # POST /messages
  def create
    @message = Message.new(chat_id: @chat.id, number: 0, content: params[:content]) 

    raise ActiveRecord::RecordInvalid.new(@chat) if !@message.valid?

    @message_number = $redis.incr(params[:appToken].to_s +  params[:chatNumber].to_s)
    
    @message.number = @message_number

    @message.save!

    @chat.messageCount = @message_number

    @chat.save!
        
    render json: {"messageNumber": @message_number}, status: :created
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message.as_json(except: [:id])
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  def search

    @query = query_params[:search]

    @messages = Message.search(@chat.id, @query)

    render json: @messages

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find_by!(chat_id: @chat.id, number: params[:number])
    end

    def set_chat
      @chat = Chat.find_by!(appToken: params[:appToken], number: params[:chatNumber])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.permit(:content)
    end

    def query_params
      params.permit(:search)
    end
end
