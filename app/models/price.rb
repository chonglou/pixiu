class Price < ActiveRecord::Base
  validates :product_id, presence: true
  belongs_to :product
  enum flags: [:cny, :hkd, :mop, :twd, :jpy, :usd, :eur, :cad]
end
