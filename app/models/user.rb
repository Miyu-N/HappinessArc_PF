class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :likes, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :posts, dependent: :destroy
  
  attachment :profile_image
  
  # deviseメソッド：退会（論理削除）後のログイン
  def active_for_authentication?
    super && (self.is_deleted == false)
  end
  
  
end
