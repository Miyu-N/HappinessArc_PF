class Post < ApplicationRecord
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  belongs_to :user
  belongs_to :category
  attachment :image
  
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
  
  
end
