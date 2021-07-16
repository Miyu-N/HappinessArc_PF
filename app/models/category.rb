class Category < ApplicationRecord
  has_many :posts, dependent: :destroy
  
  validates :name, presence: true
  
  def Category.search(word)
    Category.where(name: "#{word}")
  end
  
end
