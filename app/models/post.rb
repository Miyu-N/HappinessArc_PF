class Post < ApplicationRecord
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :view_counts, dependent: :destroy
  belongs_to :user
  belongs_to :category
  attachment :image

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%'+content)
    else
      Book.where('title LIKE ?', '%'+content+'%')
    end
  end


end
