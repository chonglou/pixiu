class Price < ActiveRecord::Base
  validates :product_id, presence: true
  validates :product_id, uniqueness: {scope: :flag}
  validates_numericality_of :value, greater_than:0
  belongs_to :product
  enum flags: {cny:1, hkd:2, mop:3, twd:4, jpy:5, usd:6, eur:7, gbp:8, cad:9}

  def flag_s
    I18n.t("helpers.label.price.flags.#{Price.flags.invert[self.flag]}")
  end
end
