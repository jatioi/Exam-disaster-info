class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :address, presence: true

  has_many :post_category_ships
  has_many :categories, through: :post_category_ships
  has_many :comments
  belongs_to :user
end
