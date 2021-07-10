class Post < ApplicationRecord
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_many :likes, dependent: :destroy
  belongs_to :user
  belongs_to :category
  attachment :image
  
  
end
