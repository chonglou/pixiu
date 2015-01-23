class Sample < ActiveRecord::Base
  belongs_to :product
  belongs_to :attachment

  validates :attachment_id, :product_id, presence: true
end
