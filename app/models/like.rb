class Like < ApplicationRecord
  belongs_to :post
  belongs_to :users
  validates :user_id, uniqueness: { scope: :post_id }
  
end
