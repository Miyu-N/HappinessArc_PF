class Public::RoomsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    # 共通のルームidを取得
    my_rooms_ids = current_user.user_rooms.select(:room_id)
    # チャット相手のcustomer_roomを取得
    @user_rooms = UserRoom.includes(:chats, :user).where(room_id: my_rooms_ids)
                      .where.not(user_id: current_user.id).reverse_order
  end
end
