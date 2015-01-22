class Sample < ActiveRecord::Base
  belongs_to :product
  has_one :attachment

  validates :attachment_id, :product_id, presence: true
end
