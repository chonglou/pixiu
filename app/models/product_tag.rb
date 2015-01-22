class ProductTag < ActiveRecord::Base
  validates :product_uid, :tag_id, presence: true
end
