class Chat < ApplicationRecord
  belongs_to :users
  belongs_to :rooms
  has_many :user_rooms, through: :room
end
