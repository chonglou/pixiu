class VisitCounter < ActiveRecord::Base
  validates :key, uniqueness: {scope: :flag}
  validates :flag, :key, presence: true
  enum flag: {product: 1, document: 2}
end
