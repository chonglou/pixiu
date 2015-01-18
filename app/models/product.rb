class Product < ActiveRecord::Base

  validates :user_id, :uid, :name, :summary, :details, presence: true

  has_many :prices
  has_and_belongs_to_many :carts

  enum statuses: [:submit, :publish, :done]
end
