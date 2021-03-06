class Public::ChatsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    if user_rooms.nil?
      @room = Room.new
      @room.save
      UserRoom.create(user_id: @user.id, room_id: @room.id)
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
    else
      @room = user_rooms.room
    end

    @chats = @room.chats.includes([:user])
    @chat = Chat.new(room_id: @room.id)
  end
  
  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save ? (render :create) : (redirect_to request.referer)
    @room = @chat.room
    @user_room = UserRoom.where(room_id: @room.id).where.not(user_id: current_user.id)
    @another_user_room = @user_room.find_by(room_id: @room.id)
  end
  
  private
  
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
