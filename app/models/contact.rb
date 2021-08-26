class Contact < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i} # メールアドレスの正規表現
  validates :subject, presence: true
  validates :messages, presence: true
end
