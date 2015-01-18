class Cart < ActiveRecord::Base
  validates :token, presence: true
  has_and_belongs_to_many :products
end
